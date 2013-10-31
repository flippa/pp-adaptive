module AdaptivePayments
  class PayRequest < AbstractRequest
    operation :Pay

    attribute :receiver_list,                      Node[ReceiverList],      :param => "receiverList"
    attribute :action_type,                        String,                  :param => "actionType"
    attribute :currency_code,                      String,                  :param => "currencyCode"
    attribute :cancel_url,                         String,                  :param => "cancelUrl"
    attribute :return_url,                         String,                  :param => "returnUrl"
    attribute :ipn_notification_url,               String,                  :param => "ipnNotificationUrl"
    attribute :sender,                             Node[SenderIdentifier]
    attribute :preapproval_key,                    String,                  :param => "preapprovalKey"
    attribute :pin,                                String
    attribute :reverse_parallel_payments_on_error, Boolean,                 :param => "reverseAllParallelPaymentsOnError"
    attribute :tracking_id,                        String,                  :param => "trackingId"
    attribute :memo,                               String
    attribute :funding_constraint,                 Node[FundingConstraint], :param => "fundingConstraint"
    attribute :client_details,                     Node[ClientDetailsType], :param => "clientDetails"
    attribute :fees_payer,                         String,                  :param => "feesPayer"

    include ReceiverListAliases

    alias_params :client_details, {
      :client_ip_address     => :ip_address,
      :client_device_id      => :device_id,
      :client_application_id => :application_id,
      :client_model          => :model,
      :client_geo_location   => :geo_location,
      :client_customer_type  => :customer_type,
      :client_partner_name   => :partner_name,
      :client_customer_id    => :customer_id
    }

    alias_params :sender, {
      :sender_email           => :email,
      :sender_phone           => :phone,
      :use_sender_credentials => :use_credentials
    }

    alias_params :sender_phone, {
      :sender_phone_country_code => :country_code,
      :sender_phone_number       => :phone_number,
      :sender_phone_extension    => :extension
    }

    alias_params :funding_constraint, {
      :allowed_funding_type => :allowed_funding_type
    }

    alias_params :allowed_funding_type, {
      :allowed_funding_type_info => :funding_type_info
    }

    def allowed_funding_types
      allowed_funding_type_info.collect { |info| info[:funding_type] }
    end

    def allowed_funding_types=(list_of_types)
      self.allowed_funding_type_info = list_of_types.map { |t| { :funding_type => t } }
    end

    # For explicit approval, redirect the user to https://www.paypal.com/webscr?cmd=_ap-payment&paykey=value
    # When paying for DIGITALGOODS, use https://paypal.com/webapps/adaptivepayment/flow/pay?paykey=
  end
end
