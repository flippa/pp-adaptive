module AdaptivePayments
  class FundingPlanCharge < JsonModel
    attribute :charge,         Node[CurrencyType]
    attribute :funding_source, Node[FundingSource], :param => "fundingSource"

    alias_params :charge, {
      :amount        => :amount,
      :currency_code => :code
    }
  end
end
