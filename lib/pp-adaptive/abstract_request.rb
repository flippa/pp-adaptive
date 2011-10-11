module AdaptivePayments
  class AbstractRequest < JsonModel
    attribute :request_envelope, Node[RequestEnvelope], :param => "requestEnvelope"

    alias_params :request_envelope, {
      :detail_level   => :detail_level,
      :error_language => :error_language
    }

    class << self
      def operation(name = nil)
        @operation = name unless name.nil?
        @operation
      end

      def build_response(string)
        klass = AdaptivePayments.const_get(operation.to_s + "Response")
        klass.from_json(string.to_s)
      end
    end
  end
end
