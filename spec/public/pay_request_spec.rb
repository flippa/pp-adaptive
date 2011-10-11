require "spec_helper"

describe AdaptivePayments::PayRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::PayRequest }
  its(:operation) { should == :Pay }

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
      :memo                      => "a personal note"
    )
  end

  let(:json) { JSON.parse(request.to_json) }

  it "maps #receivers.first.email to ['receiverList']['receiver'][0]['email']" do
    json["receiverList"]["receiver"][0]["email"].should == "receiver1@site.com"
  end

  it "maps #receivers.last.email to ['receiverList']['receiver'][1]['email']" do
    json["receiverList"]["receiver"][1]["email"].should == "receiver2@site.com"
  end

  it "maps #receivers.first.amount to ['receiverList']['receiver'][0]['amount']" do
    json["receiverList"]["receiver"][0]["amount"].should == "20.00"
  end

  it "maps #receivers.last.amount to ['receiverList']['receiver'][1]['amount']" do
    json["receiverList"]["receiver"][1]["amount"].should == "5.00"
  end

  it "maps #receivers.last.primary to ['receiverList']['receiver'][1]['primary']" do
    json["receiverList"]["receiver"][1]["primary"].should == true
  end

  it "maps #payment_type to ['receiverList']['receiver'][0]['paymentType']" do
    json["receiverList"]["receiver"][0]["paymentType"].should == "DIGITALGOODS"
  end

  it "maps #allowed_funding_types.first to ['fundingConstraint']['allowedFundingType']['fundingTypeInfo'][0]['fundingType']" do
    json["fundingConstraint"]["allowedFundingType"]["fundingTypeInfo"][0]["fundingType"].should == "CREDITCARD"
  end

  it "maps #allowed_funding_types.last to ['fundingConstraint']['allowedFundingType']['fundingTypeInfo'][1]['fundingType']" do
    json["fundingConstraint"]["allowedFundingType"]["fundingTypeInfo"][1]["fundingType"].should == "BALANCE"
  end

  it "maps #invoice_id to ['receiverList']['receiver'][0]['invoiceId']" do
    json["receiverList"]["receiver"][0]["invoiceId"].should == "42"
  end

  it "allows setting the first receiver email with #receiver_email" do
    request.receiver_email = "another@receiver.com"
    json["receiverList"]["receiver"][0]["email"].should == "another@receiver.com"
  end

  it "allows setting the first receiver amount with #receiver_amount" do
    request.receiver_amount = 30
    json["receiverList"]["receiver"][0]["amount"].should == "30.00"
  end

  it "allows setting the first receiver phone number with #receiver_phone_number" do
    request.receiver_phone_number = "0431301201"
    json["receiverList"]["receiver"][0]["phone"]["phoneNumber"].should == "0431301201"
  end

  it "allows setting the first receiver phone country code with #receiver_phone_country_code" do
    request.receiver_phone_country_code = "61"
    json["receiverList"]["receiver"][0]["phone"]["countryCode"].should == "61"
  end

  it "allows setting the first receiver phone extension with #receiver_phone_extension" do
    request.receiver_phone_extension = "033"
    json["receiverList"]["receiver"][0]["phone"]["extension"].should == "033"
  end

  it "maps #action_type to ['actionType']" do
    json["actionType"].should == "PAY"
  end

  it "maps #preapproval_key to ['preapprovalKey']" do
    json["preapprovalKey"].should == "ABCD-1234"
  end

  it "maps #pin to ['pin']" do
    json["pin"].should == "1234"
  end

  it "maps #currency_code to ['currencyCode']" do
    json["currencyCode"].should == "USD"
  end

  it "maps #cancel_url to ['cancelUrl']" do
    json["cancelUrl"].should == "http://site.com/cancelled"
  end

  it "maps #return_url to ['returnUrl']" do
    json["returnUrl"].should == "http://site.com/success"
  end

  it "maps #ipn_notification_url to ['ipnNotificationUrl']" do
    json["ipnNotificationUrl"].should == "http://site.com/ipn"
  end

  it "maps #sender_email to ['sender']['email']" do
    json["sender"]["email"].should == "sender@site.com"
  end

  it "maps #sender_phone_country_code to ['sender']['phone']['countryCode']" do
    json["sender"]["phone"]["countryCode"].should == "61"
  end

  it "maps #sender_phone_number to ['sender']['phone']['phoneNumber']" do
    json["sender"]["phone"]["phoneNumber"].should == "0431300200"
  end

  it "maps #sender_phone_extension to ['sender']['phone']['extension']" do
    json["sender"]["phone"]["extension"].should == "033"
  end

  it "maps #reverse_parallel_payments_on_error to ['reverseAllParallelPaymentsOnError']" do
    json["reverseAllParallelPaymentsOnError"].should == false
  end

  it "maps #tracking_id to ['trackingId']" do
    json["trackingId"].should == "anything.id"
  end

  it "maps #memo to 'memo'" do
    json["memo"].should == "a personal note"
  end
end
