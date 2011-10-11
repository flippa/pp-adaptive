module AdaptivePayments
  class PreapprovalDetailsResponse < AbstractResponse
    operation :PreapprovalDetails

    attribute :approved,                   Boolean
    attribute :cancel_url,                 String,            :param => "cancelUrl"
    attribute :return_url,                 String,            :param => "returnUrl"
    attribute :ipn_notification_url,       String,            :param => "ipnNotificationUrl"
    attribute :currency_code,              String,            :param => "currencyCode"
    attribute :max_total_amount,           Decimal,           :param => "maxTotalAmountOfAllPayments"
    attribute :starting_date,              DateTime,          :param => "startingDate"
    attribute :ending_date,                DateTime,          :param => "endingDate"
    attribute :max_amount_per_payment,     Decimal,           :param => "maxAmountPerPayment"
    attribute :max_payments,               Integer,           :param => "maxNumberOfPayments"
    attribute :max_payments_per_period,    Integer,           :param => "maxNumberOfPaymentsPerPeriod"
    attribute :payment_period,             String,            :param => "paymentPeriod"
    attribute :current_payments,           Integer,           :param => "curPayments"
    attribute :current_payments_amount,    Decimal,           :param => "curPaymentsAmount"
    attribute :current_period_attempts,    Integer,           :param => "curPeriodAttempts"
    attribute :current_period_ending_date, DateTime,          :param => "curPeriodEndingDate"
    attribute :date_of_month,              Integer,           :param => "dateOfMonth"
    attribute :day_of_week,                String,            :param => "dayOfWeek"
    attribute :pin_type,                   String,            :param => "pinType"
    attribute :sender_email,               String,            :param => "senderEmail"
    attribute :memo,                       String
    attribute :status,                     String
    attribute :fees_payer,                 String,            :param => "feesPayer"
    attribute :display_max_total_amount,   Boolean,           :param => "displayMaxTotalAmount"
    attribute :address_list,               Node[AddressList], :param => "addressList"

    alias_params :address_list, {
      :addresses => :addresses
    }
  end
end
