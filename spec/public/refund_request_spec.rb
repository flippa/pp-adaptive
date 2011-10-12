require "spec_helper"

describe AdaptivePayments::RefundRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::RefundRequest }
  its(:operation) { should == :Refund }

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
    json["currencyCode"].should == "USD"
  end

  it "maps #pay_key to ['payKey']" do
    json["payKey"].should == "ABCD-1234"
  end

  it "maps #tracking_id to ['trackingId']" do
    json["trackingId"].should == "some.id"
  end

  it "maps #transaction_id to ['transactionId']" do
    json["transactionId"].should == "trans123"
  end

  it "maps #ipn_notification_url to ['ipnNotificationUrl']" do
    json["ipnNotificationUrl"].should == "http://site.com/ipn"
  end

  it "maps #receivers.first.email to ['receiverList']['receiver'][0]['email']" do
    json["receiverList"]["receiver"][0]["email"].should == "first@site.com"
  end

  it "maps #receivers.first.amount to ['receiverList']['receiver'][0]['amount']" do
    json["receiverList"]["receiver"][0]["amount"].should == "10.00"
  end

  it "maps #receivers.last.email to ['receiverList']['receiver'][1]['email']" do
    json["receiverList"]["receiver"][1]["email"].should == "other@site.com"
  end

  it "maps #receivers.last.amount to ['receiverList']['receiver'][1]['amount']" do
    json["receiverList"]["receiver"][1]["amount"].should == "2.00"
  end
end
