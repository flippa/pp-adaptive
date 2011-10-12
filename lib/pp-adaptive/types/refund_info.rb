module AdaptivePayments
  class RefundInfo < JsonModel
    attribute :receiver,                        Node[Receiver]
    attribute :refund_status,                   String,          :param => "refundStatus"
    attribute :refund_net_amount,               Decimal,         :param => "refundNetAmount"
    attribute :refund_fee_amount,               Decimal,         :param => "refundFeeAmount"
    attribute :refund_gross_amount,             Decimal,         :param => "refundGrossAmount"
    attribute :total_of_all_refunds,            Decimal,         :param => "totalOfAllRefunds"
    attribute :refund_has_become_full,          Boolean,         :param => "refundHasBecomeFull"
    attribute :encrypted_refund_transaction_id, String,          :param => "encryptedRefundTransactionId"
    attribute :refund_transaction_status,       String,          :param => "refundTransactionStatus"
    attribute :error_list,                      Node[ErrorList], :param => "errorList"

    include ReceiverAliases

    alias_params :error_list, {
      :errors => :errors
    }
  end
end
