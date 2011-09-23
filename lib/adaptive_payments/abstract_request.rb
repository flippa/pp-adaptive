require "virtus"

module AdaptivePayments
  class AbstractRequest
    include Virtus
    include RequestEnvelope

    class << self
      def operation(name = nil)
        @operation = name unless name.nil?
        @operation
      end

      def build_response(string)
        klass = AdaptivePayments.const_get(operation.to_s + "Response")
        klass.new(string)
      end
    end

    def to_hash
      attributes.inject({}) do |hash, (attr, value)|
        next hash if value.nil?
        hash.merge(param_key(attr) => value.to_s)
      end
    end

    private

    def param_key(attr)
      self.class.attributes[attr].options.fetch(:param, attr).to_s
    end
  end
end
