module AdaptivePayments
  class PaymentInfo < JsonModel
    attribute :transaction_id,            String,         :param => "transactionId"
    attribute :transaction_status,        String,         :param => "transactionStatus"
    attribute :receiver,                  Node[Receiver]
    attribute :refunded_amount,           Decimal,        :param => "refundedAmount"
    attribute :pending_refund,            Boolean,        :param => "pendingRefund"
    attribute :sender_transaction_id,     String,         :param => "senderTransactionId"
    attribute :sender_transaction_status, String,         :param => "senderTransactionStatus"
    attribute :pending_reason,            String,         :param => "pendingReason"

    include ReceiverAliases
  end

  # FIXME: Add predicates for the transaction_status
end
