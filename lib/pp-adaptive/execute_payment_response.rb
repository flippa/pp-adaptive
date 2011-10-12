module AdaptivePayments
  class ExecutePaymentResponse < AbstractResponse
    operation :ExecutePayment

    attribute :payment_exec_status, String,             :param => "paymentExecStatus"
    attribute :pay_error_list,      Node[PayErrorList], :param => "payErrorList"

    alias_params :pay_error_list, {
      :pay_errors => :pay_errors
    }
  end
end
