require "spec_helper"

describe AdaptivePayments::ExecutePaymentResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"

  let(:response) do
    AdaptivePayments::ExecutePaymentResponse.from_json(
      {
        :paymentExecStatus => "Completed",
        :payErrorList      => {
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

  it "maps ['paymentExecStatus'] to #payment_exec_status" do
    expect(response.payment_exec_status).to eq("Completed")
  end

  it "maps ['payErrorList']['payError'][0]['receiver']['email'] to #pay_errors.first.receiver_email" do
    expect(response.pay_errors.first.receiver_email).to eq("bob@site.com")
  end

  it "maps ['payErrorList']['payError'][0]['receiver']['amount'] to #pay_errors.first.receiver_amount" do
    expect(response.pay_errors.first.receiver_amount).to eq(BigDecimal("5.00"))
  end

  it "maps ['payErrorList']['payError'][0]['error']['domain'] to #pay_errors.first.error_domain" do
    expect(response.pay_errors.first.error_domain).to eq("APPLICATION")
  end

  it "maps ['payErrorList']['payError'][0]['error']['message'] to #pay_errors.first.error_message" do
    expect(response.pay_errors.first.error_message).to eq("there was an error")
  end

  it "maps ['payErrorList']['payError'][1]['receiver']['email'] to #pay_errors.last.receiver_email" do
    expect(response.pay_errors.last.receiver_email).to eq("sally@site.com")
  end

  it "maps ['payErrorList']['payError'][1]['error']['message'] to #pay_errors.last.error_message" do
    expect(response.pay_errors.last.error_message).to eq("there was another error")
  end
end
