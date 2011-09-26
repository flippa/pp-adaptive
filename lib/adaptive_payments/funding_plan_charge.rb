module AdaptivePayments
  class FundingPlanCharge < Model
    attribute :amount,         Decimal, :param => "charge.amount"
    attribute :currency_code,  String,  :param => "charge.code"
    attribute :funding_source, Object,  :param => "fundingSource", :default => lambda { |obj, attr| FundingSource.new }
  end
end
