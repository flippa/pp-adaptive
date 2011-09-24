module AdaptivePayments
  class PayResponse < AbstractResponse
    operation :Pay

    attribute :pay_key,                   String,  :param => "payKey"
    attribute :payment_exec_status,       String,  :param => "paymentExecStatus"
    attribute :funding_plan_id,           String,  :param => "defaultFundingPlan.fundingPlanId"
    attribute :funding_amount,            Decimal, :param => "defaultFundingPlan.fundingAmount.amount"
    attribute :funding_currency_code,     Decimal, :param => "defaultFundingPlan.fundingAmount.code"
    attribute :sender_fees_amount,        Decimal, :param => "defaultFundingPlan.senderFees.amount"
    attribute :sender_fees_currency_code, String,  :param => "defaultFundingPlan.senderFees.code"

    # FIXME: Add the payErrorList... depends on ErrorData, which we haven't done yet
    # Add backupFundingSource
    # add charge(0..n) for each funding source
    # add currencyConversion
  end
end
