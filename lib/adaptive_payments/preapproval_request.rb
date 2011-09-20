module AdaptivePayments
  class PreapprovalRequest < AbstractRequest
    operation :Preapproval

    attribute :ending_date,      DateTime, :param => "endingDate"
    attribute :starting_date,    DateTime, :param => "startingDate"
    attribute :max_total_amount, Decimal,  :param => "maxTotalAmountOfAllPayments"
    attribute :currency_code,    String,   :param => "currencyCode"
    attribute :cancel_url,       String,   :param => "cancelUrl"
    attribute :return_url,       String,   :param => "returnUrl"
    attribute :error_language,   String,   :param => "requestEnvelope.errorLanguage", :default => "en_US"

    def to_hash
      super.merge(param_key(:max_total_amount) => "%.2f" % max_total_amount)
    end
  end
end
