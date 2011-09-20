module AdaptivePayments
  class PreapprovalRequest < AbstractRequest
    operation :Preapproval

    attribute :ending_date,              DateTime, :param => "endingDate"
    attribute :starting_date,            DateTime, :param => "startingDate"
    attribute :max_total_amount,         Decimal,  :param => "maxTotalAmountOfAllPayments"
    attribute :currency_code,            String,   :param => "currencyCode"
    attribute :cancel_url,               String,   :param => "cancelUrl"
    attribute :return_url,               String,   :param => "returnUrl"
    attribute :ipn_notification_url,     String,   :param => "ipnNotificationUrl"
    attribute :date_of_month,            Integer,  :param => "dateOfMonth"
    attribute :day_of_week,              String,   :param => "dayOfWeek"
    attribute :max_amount_per_request,   Decimal,  :param => "maxAmountPerRequest"
    attribute :max_payments,             Integer,  :param => "maxNumberOfPayments"
    attribute :max_payments_per_period,  Integer,  :param => "maxNumberOfPaymentsPerPeriod"
    attribute :payment_period,           String,   :param => "paymentPeriod"
    attribute :memo,                     String
    attribute :sender_email,             String,   :param => "senderEmail"
    attribute :pin_type,                 String,   :param => "pinType"
    attribute :fees_payer,               String,   :param => "feesPayer"
    attribute :display_max_total_amount, Boolean,  :param => "displayMaxTotalAmount"
    attribute :error_language,           String,   :param => "requestEnvelope.errorLanguage", :default => "en_US"

    def to_hash
      hash = super
      hash[param_key(:max_total_amount)]       = "%.2f" % max_total_amount       unless max_total_amount.nil?
      hash[param_key(:max_amount_per_request)] = "%.2f" % max_amount_per_request unless max_amount_per_request.nil?
      hash
    end
  end
end
