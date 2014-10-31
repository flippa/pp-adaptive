require "spec_helper"

describe AdaptivePayments::CancelPreapprovalRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::CancelPreapprovalRequest }

  describe '#operation' do
    subject { super().operation }
    it { is_expected.to eq(:CancelPreapproval) }
  end

  let(:request) { AdaptivePayments::CancelPreapprovalRequest.new(:preapproval_key => "ABCD-1234") }
  let(:json)    { JSON.parse(request.to_json) }

  it "maps #preapproval_key to ['preapprovalKey']" do
    expect(json["preapprovalKey"]).to eq("ABCD-1234")
  end
end
