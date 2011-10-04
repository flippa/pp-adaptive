module AdaptivePayments
  class AbstractRequest < Model
    include RequestEnvelope

    def self.operation(name = nil)
      @operation = name unless name.nil?
      @operation
    end

    def self.build_response(string)
      klass = AdaptivePayments.const_get(operation.to_s + "Response")
      klass.from_string(string.to_s)
    end
  end
end
