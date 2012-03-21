module AdaptivePayments
  class ConvertCurrencyResponse < AbstractResponse
    operation :ConvertCurrency

    attribute :estimated_amount_table, Node[CurrencyConversionTable], :param => "estimatedAmountTable"

    alias_params :estimated_amount_table, {
      :currency_conversions => :currency_conversion_list
    }
  end
end
