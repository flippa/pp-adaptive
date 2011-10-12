require "spec_helper"

describe AdaptivePayments::ExecutePaymentRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::ExecutePaymentRequest }
  its(:operation) { should == :ExecutePayment }

  let(:request) do
    AdaptivePayments::ExecutePaymentRequest.new(
      :action_type     => "PAY",
      :pay_key         => "ABCD-1234",
      :funding_plan_id => "funding123"
    )
  end

  let(:json) { JSON.parse(request.to_json) }

  it "maps #action_type to ['actionType']" do
    json["actionType"].should == "PAY"
  end

  it "maps #pay_key to ['payKey']" do
    json["payKey"].should == "ABCD-1234"
  end

  it "maps #funding_plan_id to ['fundingPlanId']" do
    json["fundingPlanId"].should == "funding123"
  end
end
