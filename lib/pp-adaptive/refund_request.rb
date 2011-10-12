module AdaptivePayments
  class RefundRequest < AbstractRequest
    operation :Refund

    attribute :currency_code,        String,             :param => "currencyCode"
    attribute :pay_key,              String,             :param => "payKey"
    attribute :tracking_id,          String,             :param => "trackingId"
    attribute :transaction_id,       String,             :param => "transactionId"
    attribute :receiver_list,        Node[ReceiverList], :param => "receiverList"
    attribute :ipn_notification_url, String,             :param => "ipnNotificationUrl"

    include ReceiverListAliases
  end
end
