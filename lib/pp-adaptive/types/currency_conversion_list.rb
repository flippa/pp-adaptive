module AdaptivePayments
  class CurrencyConversionList < JsonModel
    attribute :base_amount,   Node[CurrencyType], :param => 'baseAmount'
    attribute :currency_list, Node[CurrencyList], :param => 'currencyList'

    alias_params :base_amount, {
      :base_currency_code   => :code,
      :base_currency_amount => :amount
    }

    alias_params :currency_list, {
      :currencies => :currencies
    }
  end
end
