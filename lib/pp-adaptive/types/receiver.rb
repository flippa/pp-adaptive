module AdaptivePayments
  class Receiver < JsonModel
    attribute :phone,           Node[PhoneNumberType]
    attribute :email,           String
    attribute :amount,          Decimal
    attribute :payment_type,    String,  :param => "paymentType"
    attribute :payment_subtype, String,  :param => "paymentSubType"
    attribute :primary,         Boolean
    attribute :invoice_id,      String,  :param => "invoiceId"

    alias_params :phone, {
      :phone_country_code => :country_code,
      :phone_number       => :phone_number,
      :phone_extension    => :extension
    }
  end
end
