module AdaptivePayments
  class ResponseEnvelope < JsonModel
    attribute :ack_code,        String,   :param => "ack"
    attribute :build,           String,   :param => "build"
    attribute :correlation_id,  String,   :param => "correlationId"
    attribute :time,            DateTime, :param => "timestamp"

    ["Success", "Failure", "Warning", "SuccessWithWarning", "FailureWithWarning"].each do |ack|
      method = ack.split(/(?=[A-Z])/).map{ |w| w.downcase }.join("_") + "?"
      define_method(method) { ack_code == ack }
    end
  end
end
