module AdaptivePayments
  class PreapprovalResponse < AbstractResponse
    operation :Preapproval

    attribute :preapproval_key, String,   :param => "preapprovalKey"
    attribute :ack_code,        String,   :param => "responseEnvelope.ack"
    attribute :build,           String,   :param => "responseEnvelope.build"
    attribute :correlation_id,  String,   :param => "responseEnvelope.correlationId"
    attribute :time,            DateTime, :param => "responseEnvelope.timestamp"
  end
end
