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
    response.payment_exec_status.should == "Completed"
  end

  it "maps ['payErrorList']['payError'][0]['receiver']['email'] to #pay_errors.first.receiver_email" do
    response.pay_errors.first.receiver_email.should == "bob@site.com"
  end

  it "maps ['payErrorList']['payError'][0]['receiver']['amount'] to #pay_errors.first.receiver_amount" do
    response.pay_errors.first.receiver_amount.should == BigDecimal("5.00")
  end

  it "maps ['payErrorList']['payError'][0]['error']['domain'] to #pay_errors.first.error_domain" do
    response.pay_errors.first.error_domain.should == "APPLICATION"
  end

  it "maps ['payErrorList']['payError'][0]['error']['message'] to #pay_errors.first.error_message" do
    response.pay_errors.first.error_message.should == "there was an error"
  end

  it "maps ['payErrorList']['payError'][1]['receiver']['email'] to #pay_errors.last.receiver_email" do
    response.pay_errors.last.receiver_email.should == "sally@site.com"
  end

  it "maps ['payErrorList']['payError'][1]['error']['message'] to #pay_errors.last.error_message" do
    response.pay_errors.last.error_message.should == "there was another error"
  end
end
