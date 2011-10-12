module AdaptivePayments
  class RefundRequest < AbstractRequest
    operation :Refund

    attribute :currency_code,        String,             :param => "currencyCode"
    attribute :pay_key,              String,             :param => "payKey"
    attribute :tracking_id,          String,             :param => "trackingId"
    attribute :transaction_id,       String,             :param => "transactionId"
    attribute :receiver_list,        Node[ReceiverList], :param => "receiverList"
    attribute :ipn_notification_url, String,             :param => "ipnNotificationUrl" # Note that this is mentioned in the docs, but not diagrammed in the UML

    alias_params :receiver_list, {
      :receivers => :receivers
    }

    alias_params :first_receiver, {
      :receiver_email  => :email,
      :receiver_amount => :amount,
      :payment_type    => :payment_type,
      :payment_subtype => :payment_subtype,
      :invoice_id      => :invoice_id,
      :receiver_phone  => :phone
    }

    alias_params :receiver_phone, {
      :receiver_phone_number       => :phone_number,
      :receiver_phone_country_code => :country_code,
      :receiver_phone_extension    => :extension
    }

    private

    def first_receiver
      receivers[0] ||= Receiver.new
    end
  end
end
