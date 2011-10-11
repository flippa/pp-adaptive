module AdaptivePayments
  class PaymentDetailsRequest < AbstractRequest
    operation :PaymentDetails

    attribute :pay_key,        String, :param => "payKey"
    attribute :transaction_id, String, :param => "transactionId"
    attribute :tracking_id,    String, :param => "trackingId"
  end
end
