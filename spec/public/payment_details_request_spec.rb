require "spec_helper"

describe AdaptivePayments::PaymentDetailsRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::PaymentDetailsRequest }
  its(:operation) { should == :PaymentDetails }

  let(:request) do
    AdaptivePayments::PaymentDetailsRequest.new(
      :pay_key        => "ABCDEFG-1234",
      :transaction_id => "PPX-123ABC",
      :tracking_id    => "personal.id"
    )
  end

  let(:json) { JSON.parse(request.to_json) }

  it "maps #pay_key to ['payKey']" do
    json["payKey"].should == "ABCDEFG-1234"
  end

  it "maps #transaction_id to ['transactionId']" do
    json["transactionId"].should == "PPX-123ABC"
  end

  it "maps #tracking_id to ['trackingId']" do
    json["trackingId"].should == "personal.id"
  end
end
