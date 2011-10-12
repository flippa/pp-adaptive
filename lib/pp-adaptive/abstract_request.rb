module AdaptivePayments
  # AbstractRequest is a JsonModel that defines some default behaviour for all requests
  #
  # A request defines the operation it executes and provides a method for building the corresponding response.
  # All requests provide a RequestEnvelope by default.  There is no need to re-define it in descendants.
  class AbstractRequest < JsonModel
    # The RequestEnvelope, providing the detail_level and error_language.
    #
    # Aliases are defined for #detail_level and #error_language.  They do not need to be accessed through the
    # request_envelope.
    attribute :request_envelope, Node[RequestEnvelope], :param => "requestEnvelope"

    alias_params :request_envelope, {
      :detail_level   => :detail_level,
      :error_language => :error_language
    }

    class << self
      # Set or get the API operation for the request class
      #
      # @param [Symbol] name
      #   the name of the operation defined in the Adaptive Payments API, optional
      #
      # @return [Symbol]
      #   the name of the operation defined in the Adaptive Payments API
      def operation(name = nil)
        @operation = name unless name.nil?
        @operation
      end

      # Given a JSON string, return the corresponding response.
      #
      # @param [String] json
      #   the raw JSON string as returned by the API
      #
      # @return [AbstractResponse]
      #   the corresponding response for the JSON
      def build_response(json)
        klass = AdaptivePayments.const_get(operation.to_s + "Response")
        klass.from_json(json.to_s)
      end
    end
  end
end
