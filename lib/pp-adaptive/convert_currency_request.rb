module AdaptivePayments
  class ConvertCurrencyRequest < AbstractRequest
    operation :ConvertCurrency

    attribute :base_amount_list,         Node[CurrencyList],     :param => "baseAmountList"
    attribute :convert_to_currency_list, NodeList[CurrencyCode], :param => "convertToCurrencyList"
    attribute :country_code,             String,                 :param => "countryCode"
    attribute :conversion_type,          String,                 :param => "conversionType"

    alias_params :base_amount_list, {
      :currencies => :currencies
    }

    alias_params :first_currency, {
      :amount     => :amount,
      :code       => :code
    }

    def convert_to_currencies
      convert_to_currency_list.collect { |info| info[:code] }
    end
    
    def convert_to_currencies=(list_of_currencies)
      self.convert_to_currency_list = list_of_currencies.map { |t| { :code => t } }
    end

    private

    def first_currency
      currencies[0] ||= CurrencyList.new
    end
  end
end
