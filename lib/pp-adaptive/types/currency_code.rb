module AdaptivePayments
  class CurrencyCode < JsonModel
    attribute :code, String, :param => "currencyCode"
  end
end
