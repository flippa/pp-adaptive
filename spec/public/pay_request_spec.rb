require "spec_helper"

describe AdaptivePayments::PayRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::PayRequest }

  describe '#operation' do
    subject { super().operation }
    it { is_expected.to eq(:Pay) }
  end

  let(:request) do
    AdaptivePayments::PayRequest.new(
      :receivers                 => [ { :email => "receiver1@site.com", :amount => 20 }, { :email => "receiver2@site.com", :amount => 5, :primary => true } ],
      :action_type               => "PAY",
      :payment_type              => "DIGITALGOODS",
      :allowed_funding_types     => ["CREDITCARD", "BALANCE"],
      :invoice_id                => "42",
      :preapproval_key           => "ABCD-1234",
      :pin                       => "1234",
      :currency_code             => "USD",
      :cancel_url                => "http://site.com/cancelled",
      :return_url                => "http://site.com/success",
      :ipn_notification_url      => "http://site.com/ipn",
      :sender_email              => "sender@site.com",
      :sender_phone_country_code => "61",
      :sender_phone_number       => "0431300200",
      :sender_phone_extension    => "033",
      :reverse_parallel_payments_on_error => false,
      :tracking_id               => "anything.id",
      :memo                      => "a personal note",
      :fees_payer                => "PRIMARYRECEIVER"
    )
  end

  let(:json) { JSON.parse(request.to_json) }

  it "maps #receivers.first.email to ['receiverList']['receiver'][0]['email']" do
    expect(json["receiverList"]["receiver"][0]["email"]).to eq("receiver1@site.com")
  end

  it "maps #receivers.last.email to ['receiverList']['receiver'][1]['email']" do
    expect(json["receiverList"]["receiver"][1]["email"]).to eq("receiver2@site.com")
  end

  it "maps #receivers.first.amount to ['receiverList']['receiver'][0]['amount']" do
    expect(json["receiverList"]["receiver"][0]["amount"]).to eq("20.00")
  end

  it "maps #receivers.last.amount to ['receiverList']['receiver'][1]['amount']" do
    expect(json["receiverList"]["receiver"][1]["amount"]).to eq("5.00")
  end

  it "maps #receivers.last.primary to ['receiverList']['receiver'][1]['primary']" do
    expect(json["receiverList"]["receiver"][1]["primary"]).to eq(true)
  end

  it "maps #payment_type to ['receiverList']['receiver'][0]['paymentType']" do
    expect(json["receiverList"]["receiver"][0]["paymentType"]).to eq("DIGITALGOODS")
  end

  it "maps #allowed_funding_types.first to ['fundingConstraint']['allowedFundingType']['fundingTypeInfo'][0]['fundingType']" do
    expect(json["fundingConstraint"]["allowedFundingType"]["fundingTypeInfo"][0]["fundingType"]).to eq("CREDITCARD")
  end

  it "maps #allowed_funding_types.last to ['fundingConstraint']['allowedFundingType']['fundingTypeInfo'][1]['fundingType']" do
    expect(json["fundingConstraint"]["allowedFundingType"]["fundingTypeInfo"][1]["fundingType"]).to eq("BALANCE")
  end

  it "maps #invoice_id to ['receiverList']['receiver'][0]['invoiceId']" do
    expect(json["receiverList"]["receiver"][0]["invoiceId"]).to eq("42")
  end

  it "allows setting the first receiver email with #receiver_email" do
    request.receiver_email = "another@receiver.com"
    expect(json["receiverList"]["receiver"][0]["email"]).to eq("another@receiver.com")
  end

  it "allows setting the first receiver amount with #receiver_amount" do
    request.receiver_amount = 30
    expect(json["receiverList"]["receiver"][0]["amount"]).to eq("30.00")
  end

  it "allows setting the first receiver phone number with #receiver_phone_number" do
    request.receiver_phone_number = "0431301201"
    expect(json["receiverList"]["receiver"][0]["phone"]["phoneNumber"]).to eq("0431301201")
  end

  it "allows setting the first receiver phone country code with #receiver_phone_country_code" do
    request.receiver_phone_country_code = "61"
    expect(json["receiverList"]["receiver"][0]["phone"]["countryCode"]).to eq("61")
  end

  it "allows setting the first receiver phone extension with #receiver_phone_extension" do
    request.receiver_phone_extension = "033"
    expect(json["receiverList"]["receiver"][0]["phone"]["extension"]).to eq("033")
  end

  it "maps #action_type to ['actionType']" do
    expect(json["actionType"]).to eq("PAY")
  end

  it "maps #preapproval_key to ['preapprovalKey']" do
    expect(json["preapprovalKey"]).to eq("ABCD-1234")
  end

  it "maps #pin to ['pin']" do
    expect(json["pin"]).to eq("1234")
  end

  it "maps #currency_code to ['currencyCode']" do
    expect(json["currencyCode"]).to eq("USD")
  end

  it "maps #cancel_url to ['cancelUrl']" do
    expect(json["cancelUrl"]).to eq("http://site.com/cancelled")
  end

  it "maps #return_url to ['returnUrl']" do
    expect(json["returnUrl"]).to eq("http://site.com/success")
  end

  it "maps #ipn_notification_url to ['ipnNotificationUrl']" do
    expect(json["ipnNotificationUrl"]).to eq("http://site.com/ipn")
  end

  it "maps #sender_email to ['sender']['email']" do
    expect(json["sender"]["email"]).to eq("sender@site.com")
  end

  it "maps #sender_phone_country_code to ['sender']['phone']['countryCode']" do
    expect(json["sender"]["phone"]["countryCode"]).to eq("61")
  end

  it "maps #sender_phone_number to ['sender']['phone']['phoneNumber']" do
    expect(json["sender"]["phone"]["phoneNumber"]).to eq("0431300200")
  end

  it "maps #sender_phone_extension to ['sender']['phone']['extension']" do
    expect(json["sender"]["phone"]["extension"]).to eq("033")
  end

  it "maps #reverse_parallel_payments_on_error to ['reverseAllParallelPaymentsOnError']" do
    expect(json["reverseAllParallelPaymentsOnError"]).to eq(false)
  end

  it "maps #tracking_id to ['trackingId']" do
    expect(json["trackingId"]).to eq("anything.id")
  end

  it "maps #memo to 'memo'" do
    expect(json["memo"]).to eq("a personal note")
  end
end
