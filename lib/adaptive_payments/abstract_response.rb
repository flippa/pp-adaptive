module AdaptivePayments
  class AbstractResponse < Model
    include ResponseEnvelope
    include FaultMessage

    def self.operation(name = nil)
      @operation = name unless name.nil?
      @operation
    end
  end
end
