module AdaptivePayments
  class PayResponse < AbstractResponse
    operation :Pay

    attribute :pay_key,                   String,  :param => "payKey"
    attribute :payment_exec_status,       String,  :param => "paymentExecStatus"
    attribute :funding_plan_id,           String,  :param => "defaultFundingPlan.fundingPlanId"
    attribute :funding_amount,            Decimal, :param => "defaultFundingPlan.fundingAmount.amount"
    attribute :funding_currency_code,     String,  :param => "defaultFundingPlan.fundingAmount.code"
    attribute :sender_fees_amount,        Decimal, :param => "defaultFundingPlan.senderFees.amount"
    attribute :sender_fees_currency_code, String,  :param => "defaultFundingPlan.senderFees.code"
    attribute :pay_errors,                Object,  :param => "payErrorList.payError", :default => lambda { |obj, attr| List.new(PayError) }
    attribute :backup_funding_source,     Object,  :param => "defaultFundingPlan.backupFundingSource", :default => lambda { |obj, attr| FundingSource.new  }
    attribute :from_currency_amount,      Decimal, :param => "defaultFundingPlan.currencyConversion.from.amount"
    attribute :from_currency_code,        String,  :param => "defaultFundingPlan.currencyConversion.from.code"
    attribute :to_currency_amount,        Decimal, :param => "defaultFundingPlan.currencyConversion.to.amount"
    attribute :to_currency_code,          String,  :param => "defaultFundingPlan.currencyConversion.to.code"
    attribute :exchange_rate,             Decimal, :param => "defaultFundingPlan.currencyConversion.exchangeRate"
    attribute :charges,                   Object,  :param => "defaultFundingPlan.charge", :default => lambda { |obj, attr| List.new(FundingPlanCharge) }
  end
end
