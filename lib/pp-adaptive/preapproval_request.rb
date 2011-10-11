module AdaptivePayments
  class PreapprovalRequest < AbstractRequest
    operation :Preapproval

    attribute :client_details,           Node[ClientDetailsType], :param => "clientDetails"
    attribute :ending_date,              DateTime,                :param => "endingDate"
    attribute :starting_date,            DateTime,                :param => "startingDate"
    attribute :max_total_amount,         Decimal,                 :param => "maxTotalAmountOfAllPayments"
    attribute :currency_code,            String,                  :param => "currencyCode"
    attribute :cancel_url,               String,                  :param => "cancelUrl"
    attribute :return_url,               String,                  :param => "returnUrl"
    attribute :ipn_notification_url,     String,                  :param => "ipnNotificationUrl"
    attribute :date_of_month,            Integer,                 :param => "dateOfMonth"
    attribute :day_of_week,              String,                  :param => "dayOfWeek"
    attribute :max_amount_per_payment,   Decimal,                 :param => "maxAmountPerPayment"
    attribute :max_payments,             Integer,                 :param => "maxNumberOfPayments"
    attribute :max_payments_per_period,  Integer,                 :param => "maxNumberOfPaymentsPerPeriod"
    attribute :payment_period,           String,                  :param => "paymentPeriod"
    attribute :memo,                     String
    attribute :sender_email,             String,                  :param => "senderEmail"
    attribute :pin_type,                 String,                  :param => "pinType"
    attribute :fees_payer,               String,                  :param => "feesPayer"
    attribute :display_max_total_amount, Boolean,                 :param => "displayMaxTotalAmount"

    alias_params :client_details, {
      :client_ip_address     => :ip_address,
      :client_device_id      => :device_id,
      :client_application_id => :application_id,
      :client_model          => :model,
      :client_geo_location   => :geo_location,
      :client_customer_type  => :customer_type,
      :client_partner_name   => :partner_name,
      :client_customer_id    => :customer_id
    }
  end
end
