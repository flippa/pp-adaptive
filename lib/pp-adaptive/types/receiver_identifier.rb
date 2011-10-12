module AdaptivePayments
  class ReceiverIdentifier < JsonModel
    attribute :email, String
    attribute :phone, Node[PhoneNumberType]

    alias_params :phone, {
      :phone_country_code => :country_code,
      :phone_number       => :phone_number,
      :phone_extension    => :extension
    }
  end
end
