require "virtus"

module AdaptivePayments
  class AbstractResponse < Model
    include ResponseEnvelope
    include FaultMessage

    class << self
      def operation(name = nil)
        @operation = name unless name.nil?
        @operation
      end
    end
  end
end
