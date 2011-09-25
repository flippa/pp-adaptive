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

    # FIXME: Add backupFundingSource
    # FIXME: add charge(0..n) for each funding source
    # FIXME: add currencyConversion
  end
end
