module AdaptivePayments
  class PayError < JsonModel
    attribute :receiver, Node[Receiver]
    attribute :error,    Node[ErrorData]

    include ReceiverAliases

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
