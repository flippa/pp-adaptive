module AdaptivePayments
  class FundingConstraint < JsonModel
    attribute :allowed_funding_type, Node[FundingTypeList], :param => "allowedFundingType"
  end
end
