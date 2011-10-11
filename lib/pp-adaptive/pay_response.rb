module AdaptivePayments
  class PayResponse < AbstractResponse
    operation :Pay

    attribute :pay_key,                   String,             :param => "payKey"
    attribute :payment_exec_status,       String,             :param => "paymentExecStatus"
    attribute :default_funding_plan,      Node[FundingPlan],  :param => "defaultFundingPlan"
    attribute :pay_error_list,            Node[PayErrorList], :param => "payErrorList"

    alias_params :default_funding_plan, {
      :funding_plan_id           => :id,
      :funding_amount            => :amount,
      :funding_currency_code     => :currency_code,
      :backup_funding_source     => :backup_funding_source,
      :sender_fees_amount        => :sender_fees_amount,
      :sender_fees_currency_code => :sender_fees_currency_code,
      :from_currency_amount      => :from_currency_amount,
      :from_currency_code        => :from_currency_code,
      :to_currency_amount        => :to_currency_amount,
      :to_currency_code          => :to_currency_code,
      :exchange_rate             => :exchange_rate,
      :charges                   => :charges
    }

    alias_params :pay_error_list, {
      :pay_errors => :pay_errors
    }
  end
end
