module AdaptivePayments
  class FundingTypeInfo < Model
    attribute :funding_type, String, :param => "fundingType"

    def initialize(attributes = {})
      attributes = { :funding_type => attributes } if attributes.kind_of?(String)
      super
    end

    def ==(other)
      super || funding_type == other
    end

    def eql?(other)
      super || funding_type.eql?(other)
    end

    def to_s
      funding_type
    end
  end
end
