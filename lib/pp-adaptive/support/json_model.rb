require "virtus"
require "json"

module AdaptivePayments
  # A client-side, nestable, model based on Virtus, mapping JSON parameters to method names and vice-versa
  #
  # All types defined in the Adaptive Payments API documentation (both request and response) are built from this class.
  #
  #   class CurrencyConversion < JsonModel
  #     attribute :from,          Node[CurrencyType]
  #     attribute :to,            Node[CurrencyType]
  #     attribute :exchange_rate, Decimal, :param => "exchangeRate"
  #
  #     alias_params :from, {
  #       :from_amount        => :amount,
  #       :from_currency_code => :code
  #     }
  #
  #     alias_params :to, {
  #       :to_amount        => :amount,
  #       :to_currency_code => :code
  #     }
  #   end
  #
  # Virtus will allow varying input types and will cast them accordingly, so assigning '0.8767' to #exchange_rate in the
  # above example will actually store BigDecimal('0.8767') in the model.
  #
  # The optional :param option defines the name of the property in the JSON representation, if it is different from the
  # name of the attribute itself.
  #
  # In the above example, #alias_params has been used to create shortcuts to the #amount and #code attributes of the
  # two [CurrencyType] attributes, #from and #to.  So:
  #
  #   conversion.from_amount == conversion.from.amount
  #   conversion.from_currency_code == conversion.from.code
  #
  # It's possible to repeatedly create aliases like this, by chaining them together through multiple levels of the object
  # graph.  The Adaptive Payments API is rather deeply nested and verbose by default, so to be a little easier to use and
  # feel more ruby-esque, pp-adaptive define aliases where it seems logical to do so.  The fully qualified paths will always
  # work, however.
  class JsonModel
    include Virtus
    extend  Aliases

    # Methods used for building a JsonModel given a JSON string.
    module Parsing
      # Process JSON input and return a JsonModel for the data.
      #
      # This method must be invoked on a subclass of the correct type.  Invoking it on JsonModel itself will do nothing.
      # All parameters in the JSON are recursively mapped to their attribute names, based on :param on the attribute.
      # Unknown parameters are ignored.
      #
      # @param [String] json
      #   the raw JSON string as returned by the API
      #
      # @return [JsonModel]
      #   a JsonModel mapped against the provided JSON
      def from_json(json)
        new(to_attributes(JSON.parse(json)))
      end

      # Given a ruby Hash representation of raw JSON from the API (or a subset thereof), map all JSON parameter keys to attribute names
      #
      # @param [Hash] json
      #   a ruby Hash representing a subset of the overall JSON structure
      #
      # @return [Hash]
      #   a new Hash with all keys mapped to their attribute names
      def to_attributes(json)
        json = {} unless json.kind_of?(Hash)
        json.inject({}) { |hash, (key, value)| (attr_value = attribute_value(key, value)) ? hash.merge(attribute_key(key) => attr_value) : hash }
      end

      private

      def attribute_key(key)
        Hash[attribute_set.map { |attr| [attr.options.fetch(:param, attr.name).to_s, attr.name.to_sym] }][key] || key.to_sym
      end

      def attribute_value(key, value)
        return unless attribute = attribute_set[attribute_key(key)]

        case attribute
          when Node
            attribute.type.to_attributes(value)
          when NodeList
            value.map { |v| attribute.type.to_attributes(v) } if value.kind_of?(Array)
          else
            value
        end
      end
    end

    # Methods for converting a JsonModel into a JSON string for transport to the API
    module Writing
      # Recursively read all attributes in a ruby Hash, mapping attribute names to JSON parameters, according to the :param option
      #
      # @return [Hash]
      #   the JSON representation in ruby Hash form
      def to_hash
        Hash[attribute_set.map{ |a| [a.name, self[a.name]] }].
          inject({}) { |hash, (key, value)| value.nil? ? hash : hash.merge(json_key(key) => json_value(value)) }.
          reject { |key, value| value.kind_of?(Enumerable) && value.none? }
      end

      # Convert this JsonModel into a JSON string for transport to the PayPal API
      #
      # @return [String]
      #   the JSON string, containing all children, if any
      def to_json(*)
        to_hash.to_json
      end

      private

      def json_key(key)
        if self.class.attribute_set[key]
          self.class.attribute_set[key].options.fetch(:param, key).to_s
        else
          key.to_s
        end
      end

      def json_value(value)
        case value
          when JsonModel
            value.to_hash
          when CoercedArray
            value.collect { |v| v.to_hash }
          when BigDecimal, Float
            "%.2f" % value
          else
            value
        end
      end
    end

    include Writing
    extend  Parsing
  end
end
