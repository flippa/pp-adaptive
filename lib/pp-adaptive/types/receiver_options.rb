module AdaptivePayments
  class ReceiverOptions < JsonModel
    attribute :description,  String
    attribute :custom_id,    String,                   :param => "customId"
    attribute :invoice_data, Node[InvoiceData],        :param => "invoiceData"
    attribute :receiver,     Node[ReceiverIdentifier], :param => "receiver"

    alias_params :invoice_data, {
      :items          => :items,
      :total_tax      => :total_tax,
      :total_shipping => :total_shipping
    }

    alias_params :receiver, {
      :receiver_email              => :email,
      :receiver_phone_country_code => :phone_country_code,
      :receiver_phone_number       => :phone_number,
      :receiver_phone_extension    => :phone_extension
    }
  end
end
