module AdaptivePayments
  class RequestEnvelope < JsonModel
    attribute :detail_level,    String, :param => "detailLevel"
    attribute :error_language,  String, :param => "errorLanguage", :default => "en_US"
  end
end
