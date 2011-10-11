module AdaptivePayments
  class FundingPlan < JsonModel
    attribute :id,                    String,                      :param => "fundingPlanId"
    attribute :funding_amount,        Node[CurrencyType],          :param => "fundingAmount"
    attribute :backup_funding_source, Node[FundingSource],         :param => "backupFundingSource"
    attribute :sender_fees,           Node[CurrencyType],          :param => "senderFees"
    attribute :currency_conversion,   Node[CurrencyConversion],    :param => "currencyConversion"
    attribute :charges,               NodeList[FundingPlanCharge], :param => "charge"

    alias_params :funding_amount, {
      :amount        => :amount,
      :currency_code => :code
    }

    alias_params :sender_fees, {
      :sender_fees_amount        => :amount,
      :sender_fees_currency_code => :code
    }

    alias_params :currency_conversion, {
      :from_currency_amount => :from_currency_amount,
      :from_currency_code   => :from_currency_code,
      :to_currency_amount   => :to_currency_amount,
      :to_currency_code     => :to_currency_code,
      :exchange_rate        => :exchange_rate
    }
  end
end
