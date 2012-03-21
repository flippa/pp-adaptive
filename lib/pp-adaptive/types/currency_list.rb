module AdaptivePayments
  class CurrencyList < JsonModel
    attribute :currencies, NodeList[CurrencyType], :param => "currency"
  end
end
