module AdaptivePayments
  class RefundInfoList < JsonModel
    attribute :refund_info, NodeList[RefundInfo], :param => "refundInfo"
  end
end
