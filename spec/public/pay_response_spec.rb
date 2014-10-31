require "spec_helper"

describe AdaptivePayments::PayResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"

  let(:response) do
    AdaptivePayments::PayResponse.from_json(
      {
        :payKey => "ABCD-1234",
        :paymentExecStatus  => "COMPLETED",
        :defaultFundingPlan => {
          :fundingPlanId => "XXX123",
          :fundingAmount => {
            :amount => "100.00",
            :code   => "USD"
          },
          :senderFees => {
            :amount => "6.00",
            :code   => "USD"
          },
          :backupFundingSource => {
            :fundingSourceId => "9876",
            :lastFourOfAccountNumber => "0000",
            :displayName => "Primary Account",
            :type => "CREDITCARD",
            :allowed => true
          },
          :currencyConversion => {
            :from => {
              :amount => "83.33",
              :code => "GBP"
            },
            :to => {
              :amount => "100.00",
              :code => "USD"
            },
            :exchangeRate => "0.8333"
          },
          :charge => [
            :charge => {
              :amount => "5.00",
              :code => "USD"
            },
            :fundingSource => {
              :fundingSourceId => "1234"
            }
          ]
        },
        :payErrorList => {
          :payError => [
            {
              :receiver => {
                :email => "bob@site.com",
                :amount => "5.00"
              },
              :error => {
                :domain => "APPLICATION",
                :message => "there was an error"
              }
            },
            {
              :receiver => {
                :email => "sally@site.com",
                :amount => "10.00"
              },
              :error => {
                :domain => "APPLICATION",
                :message => "there was another error"
              }
            }
          ]
        }
      }.to_json
    )
  end

  it "maps ['payKey'] to #pay_key" do
    expect(response.pay_key).to eq("ABCD-1234")
  end

  it "maps ['paymentExecStatus'] to #payment_exec_status" do
    expect(response.payment_exec_status).to eq("COMPLETED")
  end

  it "maps ['defaultFundingPlan']['fundingPlanId'] to #funding_plan_id" do
    expect(response.funding_plan_id).to eq("XXX123")
  end

  it "maps ['defaultFundingPlan']['fundingAmount']['amount'] to #funding_amount" do
    expect(response.funding_amount).to eq(BigDecimal("100.00"))
  end

  it "maps ['defaultFundingPlan']['fundingAmount']['code'] to #funding_currency_code" do
    expect(response.funding_currency_code).to eq("USD")
  end

  it "maps ['defaultFundingPlan']['senderFees']['amount'] to #sender_fees_amount" do
    expect(response.sender_fees_amount).to eq(BigDecimal("6.00"))
  end

  it "maps ['defaultFundingPlan']['senderFees']['code'] to #sender_fees_currency_code" do
    expect(response.sender_fees_currency_code).to eq("USD")
  end

  it "maps ['defaultFundingPlan']['backupFundingSource']['fundingSourceId'] to #backup_funding_source.id" do
    expect(response.backup_funding_source.id).to eq("9876")
  end

  it "maps ['defaultFundingPlan']['backupFundingSource']['lastFourOfAccountNumber'] to #backup_funding_source.last_four_digits_of_account" do
    expect(response.backup_funding_source.last_four_digits_of_account).to eq("0000")
  end

  it "maps ['defaultFundingPlan']['backupFundingSource']['displayName'] to #backup_funding_source.display_name" do
    expect(response.backup_funding_source.display_name).to eq("Primary Account")
  end

  it "maps ['defaultFundingPlan']['backupFundingSource']['type'] to #backup_funding_source.type" do
    expect(response.backup_funding_source.type).to eq("CREDITCARD")
  end

  it "maps ['defaultFundingPlan']['backupFundingSource']['allowed'] to #backup_funding_source.allowed? " do
    expect(response.backup_funding_source).to be_allowed
  end

  it "maps ['defaultFundingPlan']['currencyConversion']['from']['amount'] to #from_currency_amount" do
    expect(response.from_currency_amount).to eq(BigDecimal("83.33"))
  end

  it "maps ['defaultFundingPlan']['currencyConversion']['from']['code'] to #from_currency_code" do
    expect(response.from_currency_code).to eq("GBP")
  end

  it "maps ['defaultFundingPlan']['currencyConversion']['to']['amount'] to #to_currency_amount" do
    expect(response.to_currency_amount).to eq(BigDecimal("100.00"))
  end

  it "maps ['defaultFundingPlan']['currencyConversion']['to']['code'] to #to_currency_code" do
    expect(response.to_currency_code).to eq("USD")
  end

  it "maps ['defaultFundingPlan']['currencyConversion']['exchangeRate'] to #exchange_rate" do
    expect(response.exchange_rate).to eq(BigDecimal("0.8333"))
  end

  it "maps ['defaultFundingPlan']['charge'][0]['charge']['amount'] to #charges.first.amount" do
    expect(response.charges.first.amount).to eq(BigDecimal("5.00"))
  end

  it "maps ['defaultFundingPlan']['charge'][0]['charge']['code'] to #charges.first.currency_code" do
    expect(response.charges.first.currency_code).to eq("USD")
  end

  it "maps ['defaultFundingPlan']['charge'][0]['fundingSource']['fundingSourceId'] to #charges.first.funding_source.id" do
    expect(response.charges.first.funding_source.id).to eq("1234")
  end

  it "maps ['payErrorList']['payError'][0]['receiver']['email'] to #pay_errors.first.receiver.email" do
    expect(response.pay_errors.first.receiver.email).to eq("bob@site.com")
  end

  it "allows access to ['payErrorList']['payError'][0]['receiver']['email'] with #pay_errors.first.receiver_email" do
    expect(response.pay_errors.first.receiver_email).to eq("bob@site.com")
  end

  it "maps ['payErrorList']['payError'][0]['receiver']['amount'] to #pay_errors.first.receiver.amount" do
    expect(response.pay_errors.first.receiver.amount).to eq(BigDecimal("5.00"))
  end

  it "allows access to ['payErrorList']['payError'][0]['receiver']['amount'] with #pay_errors.first.receiver_amount" do
    expect(response.pay_errors.first.receiver_amount).to eq(BigDecimal("5.00"))
  end

  it "maps ['payErrorList']['payError'][0]['error']['domain'] to #pay_errors.first.error.domain" do
    expect(response.pay_errors.first.error.domain).to eq("APPLICATION")
  end

  it "allows access to ['payErrorList']['payError'][0]['error']['domain'] with #pay_errors.first.error_domain" do
    expect(response.pay_errors.first.error_domain).to eq("APPLICATION")
  end

  it "maps ['payErrorList']['payError'][0]['error']['message'] to #pay_errors.first.error.message" do
    expect(response.pay_errors.first.error.message).to eq("there was an error")
  end

  it "allows access to ['payErrorList']['payError'][0]['error']['message'] with #pay_errors.first.error_message" do
    expect(response.pay_errors.first.error_message).to eq("there was an error")
  end

  it "maps ['payErrorList']['payError'][1]['receiver']['email'] to #pay_errors.last.receiver.email" do
    expect(response.pay_errors.last.receiver.email).to eq("sally@site.com")
  end

  it "maps ['payErrorList']['payError'][0]['error']['message'] to #pay_errors.last.error.message" do
    expect(response.pay_errors.last.error.message).to eq("there was another error")
  end
end
