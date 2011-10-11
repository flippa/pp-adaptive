module AdaptivePayments
  class FundingTypeList < JsonModel
    attribute :funding_type_infos, NodeList[FundingTypeInfo], :param => "fundingTypeInfo"
  end
end
