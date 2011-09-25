module AdaptivePayments
  class ErrorData < Model
    attribute :id,        Integer, :param => "errorId"
    attribute :domain,    String,  :param => "domain"
    attribute :subdomain, String,  :param => "subdomain"
    attribute :severity,  String,  :param => "severity"
    attribute :category,  String,  :param => "category"
    attribute :message,   String,  :param => "message"
    attribute :parameter, String,  :param => "parameter" # FIXME: This is an Array, not a String
  end
end
