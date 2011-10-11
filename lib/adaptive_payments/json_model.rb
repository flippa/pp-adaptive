require "virtus"
require "json"

module AdaptivePayments
  class JsonModel
    include Virtus
    extend  Aliases

    class << self
      def from_json(json)
        new(to_attributes(JSON.parse(json)))
      end

      def to_attributes(json)
        json = {} unless json.kind_of?(Hash)
        json.inject({}) { |hash, (key, value)| (attr_value = attribute_value(key, value)) ? hash.merge(attribute_key(key) => attr_value) : hash }
      end

      private

      def attribute_key(key)
        Hash[attributes.map { |attr| [attr.options.fetch(:param, attr.name).to_s, attr.name.to_sym] }][key] || key.to_sym
      end

      def attribute_value(key, value)
        return unless attribute = attributes[attribute_key(key)] # FIXME: This isn't passing, ever?

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

    def to_hash
      attributes.inject({}) { |hash, (key, value)| value.nil? ? hash : hash.merge(json_key(key) => json_value(value)) } \
        .reject { |key, value| value.kind_of?(Enumerable) && value.none? }
    end

    def to_json(*)
      to_hash.to_json
    end

    private

    def json_key(key)
      if self.class.attributes[key]
        self.class.attributes[key].options.fetch(:param, key).to_s
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
end
