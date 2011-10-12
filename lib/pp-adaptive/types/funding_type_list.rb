module AdaptivePayments
  class FundingTypeList < JsonModel
    attribute :funding_type_info, NodeList[FundingTypeInfo], :param => "fundingTypeInfo"
  end
end
