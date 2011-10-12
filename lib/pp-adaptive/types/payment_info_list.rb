module AdaptivePayments
  class PaymentInfoList < JsonModel
    attribute :payment_info, NodeList[PaymentInfo], :param => "paymentInfo"
  end
end
