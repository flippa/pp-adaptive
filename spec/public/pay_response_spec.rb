require "spec_helper"

describe AdaptivePayments::PayResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"

  let(:response) do
    AdaptivePayments::PayResponse.from_string([
      "payKey=ABCD-1234",
      "paymentExecStatus=COMPLETED",
      "defaultFundingPlan.fundingPlanId=XXX123",
      "defaultFundingPlan.fundingAmount.amount=100.00",
      "defaultFundingPlan.fundingAmount.code=USD",
      "defaultFundingPlan.senderFees.amount=6.00",
      "defaultFundingPlan.senderFees.code=USD",
      "payErrorList.payError(0).receiver.email=bob@site.com",
      "payErrorList.payError(0).receiver.amount=5.00",
      "payErrorList.payError(0).error.domain=APPLICATION",
      "payErrorList.payError(0).error.message=there+was+an+error",
      "payErrorList.payError(1).receiver.email=sally@site.com",
      "payErrorList.payError(1).receiver.amount=10.00",
      "payErrorList.payError(1).error.domain=APPLICATION",
      "payErrorList.payError(1).error.message=there+was+another+error"
    ].join("&"))
  end

  it "maps 'payKey' to #pay_key" do
    response.pay_key.should == "ABCD-1234"
  end

  it "maps 'paymentExecStatus' to #payment_exec_status" do
    response.payment_exec_status.should == "COMPLETED"
  end

  it "maps 'defaultFundingPlan.fundingPlanId' to #funding_plan_id" do
    response.funding_plan_id.should == "XXX123"
  end

  it "maps 'defaultFundingPlan.fundingAmount.amount' to #funding_amount" do
    response.funding_amount.should == BigDecimal("100.00")
  end

  it "maps 'defaultFundingPlan.fundingAmount.code' to #funding_currency_code" do
    response.funding_currency_code.should == "USD"
  end

  it "maps 'defaultFundingPlan.senderFees.amount' to #sender_fees_amount" do
    response.sender_fees_amount.should == BigDecimal("6.00")
  end

  it "maps 'defaultFundingPlan.senderFees.code' to #sender_fees_currency_code" do
    response.sender_fees_currency_code.should == "USD"
  end

  it "maps 'payErrorList.payError(0).receiver.email to #pay_errors.first.receiver.email" do
    response.pay_errors.first.receiver.email.should == "bob@site.com"
  end

  it "allows access to 'payErrorList.payError(0).receiver.email with #pay_errors.first.receiver_email" do
    response.pay_errors.first.receiver_email.should == "bob@site.com"
  end

  it "maps 'payErrorList.payError(0).receiver.amount to #pay_errors.first.receiver.amount" do
    response.pay_errors.first.receiver.amount.should == BigDecimal("5.00")
  end

  it "allows access to 'payErrorList.payError(0).receiver.amount with #pay_errors.first.receiver_amount" do
    response.pay_errors.first.receiver_amount.should == BigDecimal("5.00")
  end

  it "maps 'payErrorList.payError(0).error.domain' to #pay_errors.first.error.domain" do
    response.pay_errors.first.error.domain.should == "APPLICATION"
  end

  it "allows access to 'payErrorList.payError(0).error.domain' with #pay_errors.first.error_domain" do
    response.pay_errors.first.error_domain.should == "APPLICATION"
  end

  it "maps 'payErrorList.payError(0).error.message' to #pay_errors.first.error.message" do
    response.pay_errors.first.error.message.should == "there was an error"
  end

  it "allows access to 'payErrorList.payError(0).error.message' with #pay_errors.first.error_message" do
    response.pay_errors.first.error_message.should == "there was an error"
  end

  it "maps 'payErrorList.payError(1).receiver.email to #pay_errors.last.receiver.email" do
    response.pay_errors.last.receiver.email.should == "sally@site.com"
  end

  it "maps 'payErrorList.payError(0).error.message to #pay_errors.last.error.message" do
    response.pay_errors.last.error.message.should == "there was another error"
  end
end
