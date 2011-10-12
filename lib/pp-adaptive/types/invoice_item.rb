module AdaptivePayments
  class InvoiceItem < JsonModel
    attribute :name,       String
    attribute :identifier, String
    attribute :price,      Decimal
    attribute :item_price, Decimal, :param => "itemPrice"
    attribute :item_count, Integer, :param => "itemCount"
  end
end
