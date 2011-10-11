module AdaptivePayments
  class PayError < JsonModel
    attribute :receiver, Node[Receiver]
    attribute :error,    Node[ErrorData]

    alias_params :receiver, {
      :receiver_email  => :email,
      :receiver_amount => :amount,
      :payment_type    => :payment_type,
      :payment_subtype => :payment_subtype,
      :invoice_id      => :invoice_id
    }

    alias_params :error, {
      :error_id         => :id,
      :error_domain     => :domain,
      :error_subdomain  => :subdomain,
      :error_severity   => :severity,
      :error_category   => :category,
      :error_message    => :message,
      :error_parameters => :parameters
    }
  end
end
