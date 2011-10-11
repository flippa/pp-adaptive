module AdaptivePayments
  class CurrencyType < JsonModel
    attribute :amount, Decimal
    attribute :code,   String
  end
end
