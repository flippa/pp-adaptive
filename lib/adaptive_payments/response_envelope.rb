module AdaptivePayments
  module ResponseEnvelope
    class << self
      def included(base)
        base.instance_eval do
          attribute :ack_code,        String,   :param => "responseEnvelope.ack"
          attribute :build,           String,   :param => "responseEnvelope.build"
          attribute :correlation_id,  String,   :param => "responseEnvelope.correlationId"
          attribute :time,            DateTime, :param => "responseEnvelope.timestamp"

          ["Success", "Failure", "Warning", "SuccessWithWarning", "FailureWithWarning"].each do |ack|
            method = ack.split(/(?=[A-Z])/).map{ |w| w.downcase }.join("_") + "?"
            define_method(method) { ack_code == ack }
          end
        end
      end
    end
  end
end
