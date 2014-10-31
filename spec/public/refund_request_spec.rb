require "spec_helper"

describe AdaptivePayments::RefundRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::RefundRequest }

  describe '#operation' do
    subject { super().operation }
    it { is_expected.to eq(:Refund) }
  end

  let(:request) do
    AdaptivePayments::RefundRequest.new(
      :currency_code        => "USD",
      :pay_key              => "ABCD-1234",
      :tracking_id          => "some.id",
      :transaction_id       => "trans123",
      :ipn_notification_url => "http://site.com/ipn",
      :receivers            => [{ :email => "first@site.com", :amount => 10 }, { :email => "other@site.com", :amount => 2 }]
    )
  end

  let(:json) { JSON.parse(request.to_json) }

  it "maps #currency_code to ['currencyCode']" do
    expect(json["currencyCode"]).to eq("USD")
  end

  it "maps #pay_key to ['payKey']" do
    expect(json["payKey"]).to eq("ABCD-1234")
  end

  it "maps #tracking_id to ['trackingId']" do
    expect(json["trackingId"]).to eq("some.id")
  end

  it "maps #transaction_id to ['transactionId']" do
    expect(json["transactionId"]).to eq("trans123")
  end

  it "maps #ipn_notification_url to ['ipnNotificationUrl']" do
    expect(json["ipnNotificationUrl"]).to eq("http://site.com/ipn")
  end

  it "maps #receivers.first.email to ['receiverList']['receiver'][0]['email']" do
    expect(json["receiverList"]["receiver"][0]["email"]).to eq("first@site.com")
  end

  it "maps #receivers.first.amount to ['receiverList']['receiver'][0]['amount']" do
    expect(json["receiverList"]["receiver"][0]["amount"]).to eq("10.00")
  end

  it "maps #receivers.last.email to ['receiverList']['receiver'][1]['email']" do
    expect(json["receiverList"]["receiver"][1]["email"]).to eq("other@site.com")
  end

  it "maps #receivers.last.amount to ['receiverList']['receiver'][1]['amount']" do
    expect(json["receiverList"]["receiver"][1]["amount"]).to eq("2.00")
  end
end
