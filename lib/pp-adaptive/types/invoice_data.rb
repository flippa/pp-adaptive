module AdaptivePayments
  class InvoiceData < JsonModel
    attribute :items,          NodeList[InvoiceItem], :param => "item"
    attribute :total_tax,      Decimal,               :param => "totalTax"
    attribute :total_shipping, Decimal,               :param => "totalShipping"
  end
end
