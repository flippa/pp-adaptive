module AdaptivePayments
  module ReceiverListAliases
    def self.included(base)
      base.instance_eval do
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
      end
    end

    private

    def first_receiver
      receivers[0] ||= Receiver.new
    end
  end
end
