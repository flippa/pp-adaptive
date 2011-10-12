module AdaptivePayments
  class RefundResponse < AbstractResponse
    operation :Refund

    attribute :currency_code,    String,               :param => "currencyCode"
    attribute :refund_info_list, Node[RefundInfoList], :param => "refundInfoList"

    alias_params :refund_info_list, {
      :refund_info => :refund_info
    }
  end
end
