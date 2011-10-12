require "spec_helper"

describe AdaptivePayments::GetPaymentOptionsRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::GetPaymentOptionsRequest }
  its(:operation) { should == :GetPaymentOptions }

  let(:request) { AdaptivePayments::GetPaymentOptionsRequest.new(:pay_key => "ABCD-1234") }
  let(:json)    { JSON.parse(request.to_json) }

  it "maps #pay_key to ['payKey']" do
    json["payKey"].should == "ABCD-1234"
  end
end
