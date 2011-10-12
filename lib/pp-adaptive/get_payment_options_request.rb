module AdaptivePayments
  class GetPaymentOptionsRequest < AbstractRequest
    operation :GetPaymentOptions

    attribute :pay_key, String, :param => "payKey"
  end
end
