module AdaptivePayments
  class PaymentDetailsResponse < AbstractResponse
    operation :PaymentDetails

    attribute :cancel_url,                         String,                  :param => "cancelUrl"
    attribute :ipn_notification_url,               String,                  :param => "ipnNotificationUrl"
    attribute :return_url,                         String,                  :param => "returnUrl"
    attribute :memo,                               String
    attribute :currency_code,                      String,                  :param => "currencyCode"
    attribute :payment_info_list,                  Node[PaymentInfoList],   :param => "paymentInfoList"
    attribute :status,                             String
    attribute :tracking_id,                        String,                  :param => "trackingId"
    attribute :pay_key,                            String,                  :param => "payKey"
    attribute :action_type,                        String,                  :param => "actionType"
    attribute :fees_payer,                         String,                  :param => "feesPayer"
    attribute :reverse_parallel_payments_on_error, Boolean,                 :param => "reverseAllParallelPaymentsOnError"
    attribute :preapproval_key,                    String,                  :param => "preapprovalKey"
    attribute :funding_constraint,                 Node[FundingConstraint], :param => "fundingConstraint"
    attribute :sender,                             Node[SenderIdentifier]

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

    alias_params :payment_info_list, {
      :payments => :payment_info
    }

    def allowed_funding_types
      allowed_funding_type_info.collect { |info| info[:funding_type] }
    end

    def receivers
      payments.collect { |info| info[:receiver] }
    end
  end
end
