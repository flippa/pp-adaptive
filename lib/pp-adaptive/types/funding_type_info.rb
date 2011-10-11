module AdaptivePayments
  class FundingTypeInfo < JsonModel
    attribute :funding_type, String, :param => "fundingType"
  end
end
