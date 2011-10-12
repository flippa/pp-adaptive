module AdaptivePayments
  class SetPaymentOptionsRequest < AbstractRequest
    operation :SetPaymentOptions

    attribute :pay_key,             String,                     :param => "payKey"
    attribute :initiating_entity,   Node[InitiatingEntity],     :param => "initiatingEntity"
    attribute :display_options,     Node[DisplayOptions],       :param => "displayOptions"
    attribute :shipping_address_id, String,                     :param => "shippingAddressId"
    attribute :sender_options,      Node[SenderOptions],        :param => "senderOptions"
    attribute :receiver_options,    NodeList[ReceiverOptions],  :param => "receiverOptions"

    alias_params :initiating_entity, {
      :institution_id          => :institution_id,
      :customer_first_name     => :customer_first_name,
      :customer_last_name      => :customer_last_name,
      :customer_display_name   => :customer_display_name,
      :institution_customer_id => :institution_customer_id,
      :customer_country_code   => :customer_country_code,
      :customer_email          => :customer_email
    }

    alias_params :display_options, {
      :email_header_image_url    => :email_header_image_url,
      :email_marketing_image_url => :email_marketing_image_url,
      :header_image_url          => :header_image_url,
      :business_name             => :business_name
    }

    alias_params :sender_options, {
      :require_shipping_address_selection => :require_shipping_address_selection
    }
  end
end
