require "spec_helper"

describe AdaptivePayments::PreapprovalDetailsRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::PreapprovalDetailsRequest }

  describe '#operation' do
    subject { super().operation }
    it { is_expected.to eq(:PreapprovalDetails) }
  end

  let(:request) do
    AdaptivePayments::PreapprovalDetailsRequest.new(
      :preapproval_key     => "ABCDEFG-1234",
      :get_billing_address => true
    )
  end

  let(:json) { JSON.parse(request.to_json) }

  it "maps #preapproval_key to ['preapprovalKey']" do
    expect(json["preapprovalKey"]).to eq("ABCDEFG-1234")
  end

  it "maps #get_billing_address to ['getBillingAddress']" do
    expect(json["getBillingAddress"]).to eq(true)
  end
end
