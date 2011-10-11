module AdaptivePayments
  class CurrencyConversion < JsonModel
    attribute :from,          Node[CurrencyType]
    attribute :to,            Node[CurrencyType]
    attribute :exchange_rate, Decimal, :param => "exchangeRate"

    alias_params :from, {
      :from_currency_amount => :amount,
      :from_currency_code   => :code
    }

    alias_params :to, {
      :to_currency_amount => :amount,
      :to_currency_code   => :code
    }
  end
end
