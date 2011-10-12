module AdaptivePayments
  module ReceiverAliases
    def self.included(base)
      base.instance_eval do
        alias_params :receiver, {
          :receiver_email  => :email,
          :receiver_amount => :amount,
          :payment_type    => :payment_type,
          :payment_subtype => :payment_subtype,
          :invoice_id      => :invoice_id
        }
      end
    end
  end
end
