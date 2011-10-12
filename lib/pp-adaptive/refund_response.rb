module AdaptivePayments
  class RefundResponse < AbstractResponse
    operation :Refund

    attribute :currency_code,    String,               :param => "currencyCode"
    attribute :refund_info_list, Node[RefundInfoList], :param => "refundInfoList"
  end
end
