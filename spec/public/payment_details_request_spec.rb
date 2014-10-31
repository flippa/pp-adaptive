require "spec_helper"

describe AdaptivePayments::PaymentDetailsRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::PaymentDetailsRequest }

  describe '#operation' do
    subject { super().operation }
    it { is_expected.to eq(:PaymentDetails) }
  end

  let(:request) do
    AdaptivePayments::PaymentDetailsRequest.new(
      :pay_key        => "ABCDEFG-1234",
      :transaction_id => "PPX-123ABC",
      :tracking_id    => "personal.id"
    )
  end

  let(:json) { JSON.parse(request.to_json) }

  it "maps #pay_key to ['payKey']" do
    expect(json["payKey"]).to eq("ABCDEFG-1234")
  end

  it "maps #transaction_id to ['transactionId']" do
    expect(json["transactionId"]).to eq("PPX-123ABC")
  end

  it "maps #tracking_id to ['trackingId']" do
    expect(json["trackingId"]).to eq("personal.id")
  end
end
