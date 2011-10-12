module AdaptivePayments
  class ExecutePaymentRequest < AbstractRequest
    operation :ExecutePayment

    attribute :pay_key,         String, :param => "payKey"
    attribute :action_type,     String, :param => "actionType"
    attribute :funding_plan_id, String, :param => "fundingPlanId"
  end
end
