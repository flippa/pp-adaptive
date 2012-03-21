module AdaptivePayments
  class CurrencyConversionTable < JsonModel
    attribute :currency_conversion_list, NodeList[CurrencyConversionList], :param => 'currencyConversionList'
  end
end
