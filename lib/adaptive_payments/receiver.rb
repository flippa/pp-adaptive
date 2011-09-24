module AdaptivePayments
  class Receiver < RequestModel
    include Phone

    attribute :email,           String
    attribute :amount,          Decimal
    attribute :payment_type,    String, :param => "paymentType"
    attribute :payment_subtype, String, :param => "paymentSubType"
    attribute :primary,         Boolean
    attribute :invoice_id,      String, :param => "invoiceId"
  end
end
