require "spec_helper"

describe AdaptivePayments::GetPaymentOptionsRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::GetPaymentOptionsRequest }

  describe '#operation' do
    subject { super().operation }
    it { is_expected.to eq(:GetPaymentOptions) }
  end

  let(:request) { AdaptivePayments::GetPaymentOptionsRequest.new(:pay_key => "ABCD-1234") }
  let(:json)    { JSON.parse(request.to_json) }

  it "maps #pay_key to ['payKey']" do
    expect(json["payKey"]).to eq("ABCD-1234")
  end
end
