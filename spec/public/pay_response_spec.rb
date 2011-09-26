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
      "defaultFundingPlan.backupFundingSource.fundingSourceId=9876",
      "defaultFundingPlan.backupFundingSource.lastFourOfAccountNumber=0000",
      "defaultFundingPlan.backupFundingSource.displayName=Primary+Account",
      "defaultFundingPlan.backupFundingSource.type=CREDITCARD",
      "defaultFundingPlan.backupFundingSource.allowed=TRUE",
      "defaultFundingPlan.currencyConversion.from.amount=83.33",
      "defaultFundingPlan.currencyConversion.from.code=GBP",
      "defaultFundingPlan.currencyConversion.to.amount=100.00",
      "defaultFundingPlan.currencyConversion.to.code=USD",
      "defaultFundingPlan.currencyConversion.exchangeRate=0.8333",
      "defaultFundingPlan.charge(0).charge.amount=5.00",
      "defaultFundingPlan.charge(0).charge.code=USD",
      "defaultFundingPlan.charge(0).fundingSource.fundingSourceId=1234",
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

  it "maps 'defaultFundingPlan.backupFundingSource.fundingSourceId' to #backup_funding_source.id" do
    response.backup_funding_source.id.should == "9876"
  end

  it "maps 'defaultFundingPlan.backupFundingSource.lastFourOfAccountNumber' to #backup_funding_source.last_four_digits_of_account" do
    response.backup_funding_source.last_four_digits_of_account.should == "0000"
  end

  it "maps 'defaultFundingPlan.backupFundingSource.displayName' to #backup_funding_source.display_name" do
    response.backup_funding_source.display_name.should == "Primary Account"
  end

  it "maps 'defaultFundingPlan.backupFundingSource.type' to #backup_funding_source.type" do
    response.backup_funding_source.type.should == "CREDITCARD"
  end

  it "maps 'defaultFundingPlan.backupFundingSource.allowed' to #backup_funding_source.allowed? " do
    response.backup_funding_source.should be_allowed
  end

  it "maps 'defaultFundingPlan.currencyConversion.from.amount' to #from_currency_amount" do
    response.from_currency_amount.should == BigDecimal("83.33")
  end

  it "maps 'defaultFundingPlan.currencyConversion.from.code' to #from_currency_code" do
    response.from_currency_code.should == "GBP"
  end

  it "maps 'defaultFundingPlan.currencyConversion.to.amount' to #to_currency_amount" do
    response.to_currency_amount.should == BigDecimal("100.00")
  end

  it "maps 'defaultFundingPlan.currencyConversion.to.code' to #to_currency_code" do
    response.to_currency_code.should == "USD"
  end

  it "maps 'defaultFundingPlan.currencyConversion.exchangeRate' to #exchange_rate" do
    response.exchange_rate.should == BigDecimal("0.8333")
  end

  it "maps 'defaultFundingPlan.charge(0).charge.amount to #charges.first.amount" do
    response.charges.first.amount.should == BigDecimal("5.00")
  end

  it "maps 'defaultFundingPlan.charge(0).charge.code to #charges.first.currency_code" do
    response.charges.first.currency_code.should == "USD"
  end

  it "maps 'defaultFundingPlan.charge(0).fundingSource.fundingSourceId to #charges.first.funding_source.id" do
    response.charges.first.funding_source.id.should == "1234"
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
