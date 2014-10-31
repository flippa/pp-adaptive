require "spec_helper"

describe AdaptivePayments::ExecutePaymentRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::ExecutePaymentRequest }

  describe '#operation' do
    subject { super().operation }
    it { is_expected.to eq(:ExecutePayment) }
  end

  let(:request) do
    AdaptivePayments::ExecutePaymentRequest.new(
      :action_type     => "PAY",
      :pay_key         => "ABCD-1234",
      :funding_plan_id => "funding123"
    )
  end

  let(:json) { JSON.parse(request.to_json) }

  it "maps #action_type to ['actionType']" do
    expect(json["actionType"]).to eq("PAY")
  end

  it "maps #pay_key to ['payKey']" do
    expect(json["payKey"]).to eq("ABCD-1234")
  end

  it "maps #funding_plan_id to ['fundingPlanId']" do
    expect(json["fundingPlanId"]).to eq("funding123")
  end
end
