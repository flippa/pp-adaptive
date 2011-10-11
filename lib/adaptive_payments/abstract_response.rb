module AdaptivePayments
  class AbstractResponse < JsonModel
    include FaultMessage

    attribute :response_envelope, Node[ResponseEnvelope], :param => "responseEnvelope"

    alias_params :response_envelope, {
      :ack_code       => :ack_code,
      :build          => :build,
      :correlation_id => :correlation_id,
      :time           => :time
    }

    class << self
      def operation(name = nil)
        @operation = name unless name.nil?
        @operation
      end
    end

    %w{success? failure? warning? success_with_warning? failure_with_warning?}.each do |method|
      define_method(method) { responseEnvelope.send(method) }
    end
  end
end
