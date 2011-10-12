require "spec_helper"

describe AdaptivePayments::SetPaymentOptionsRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::SetPaymentOptionsRequest }
  its(:operation) { should == :SetPaymentOptions }

  let(:request) do
    AdaptivePayments::SetPaymentOptionsRequest.new(
      {
        :pay_key                   => "ABCD-1234",
        :institution_id            => "inst123",
        :customer_first_name       => "Bob",
        :customer_last_name        => "Cat",
        :customer_display_name     => "Bobcat",
        :institution_customer_id   => "77",
        :customer_country_code     => "AU",
        :customer_email            => "bob@site.com",
        :email_header_image_url    => "http://site.com/email.png",
        :email_marketing_image_url => "http://site.com/marketing.png",
        :header_image_url          => "http://site.com/header.png",
        :business_name             => "Bobcats R us",
        :shipping_address_id       => "addr123",
        :require_shipping_address_selection => true,
        :receiver_options => [
          {
            :description => "Primary receiver",
            :custom_id   => "cust123",
            :items       => [
              {
                :name       => "Video Game",
                :identifier => "ident123",
                :price      => "20.00",
                :item_price => "10.00",
                :item_count => "2"
              }
            ],
            :total_tax      => "2.00",
            :total_shipping => "0.00"
          }
        ]
      }
    )
  end

  let(:json)    { JSON.parse(request.to_json) }

  it "maps #pay_key to ['payKey']" do
    json["payKey"].should == "ABCD-1234"
  end

  it "maps #institution_id to ['initiatingEntity']['institutionCustomer']['institutionId']" do
    json["initiatingEntity"]["institutionCustomer"]["institutionId"].should == "inst123"
  end

  it "maps #customer_first_name to ['initiatingEntity']['institutionCustomer']['firstName']" do
    json["initiatingEntity"]["institutionCustomer"]["firstName"].should == "Bob"
  end

  it "maps #customer_last_name to ['initiatingEntity']['institutionCustomer']['lastName']" do
    json["initiatingEntity"]["institutionCustomer"]["lastName"].should == "Cat"
  end

  it "maps #customer_display_name to ['initiatingEntity']['institutionCustomer']['displayName']" do
    json["initiatingEntity"]["institutionCustomer"]["displayName"].should == "Bobcat"
  end

  it "maps #institution_customer_id to ['initiatingEntity']['institutionCustomer']['institutionCustomerId']" do
    json["initiatingEntity"]["institutionCustomer"]["institutionCustomerId"].should == "77"
  end

  it "maps #customer_country_code to ['initiatingEntity']['institutionCustomer']['countryCode']" do
    json["initiatingEntity"]["institutionCustomer"]["countryCode"].should == "AU"
  end

  it "maps #customer_email to ['initiatingEntity']['institutionCustomer']['email']" do
    json["initiatingEntity"]["institutionCustomer"]["email"].should == "bob@site.com"
  end

  it "maps #email_header_image_url to ['displayOptions']['emailHeaderImageUrl']" do
    json["displayOptions"]["emailHeaderImageUrl"].should == "http://site.com/email.png"
  end

  it "maps #email_marketing_image_url to ['displayOptions']['emailMarketingImageUrl']" do
    json["displayOptions"]["emailMarketingImageUrl"].should == "http://site.com/marketing.png"
  end

  it "maps #header_image_url to ['displayOptions']['headerImageUrl']" do
    json["displayOptions"]["headerImageUrl"].should == "http://site.com/header.png"
  end

  it "maps #shipping_address_id to ['shippingAddressId']" do
    json["shippingAddressId"].should == "addr123"
  end

  it "maps #require_shipping_address_selection?  to ['senderOptions']['requireShippingAddressSelection']" do
    json["senderOptions"]["requireShippingAddressSelection"].should be_true
  end

  it "maps #receiver_options.first.description to ['receiverOptions'][0]['description']" do
    json["receiverOptions"][0]["description"].should == "Primary receiver"
  end

  it "maps #receiver_options.first.custom_id to ['receiverOptions'][0]['customId']" do
    json["receiverOptions"][0]["customId"].should == "cust123"
  end

  it "maps #receiver_options.first.invoice_data.total_tax to ['receiverOptions'][0]['invoiceData']['totalTax']" do
    json["receiverOptions"][0]["invoiceData"]["totalTax"].should == "2.00"
  end

  it "maps #receiver_options.first.invoice_data.total_shipping to ['receiverOptions'][0]['invoiceData']['totalShipping']" do
    json["receiverOptions"][0]["invoiceData"]["totalShipping"].should == "0.00"
  end

  it "maps #receiver_options.first.invoice_data.items.first.name to ['receiverOptions'][0]['invoiceData']['item'][0]['name']" do
    json["receiverOptions"][0]["invoiceData"]["item"][0]["name"].should == "Video Game"
  end

  it "maps #receiver_options.first.invoice_data.items.first.identifier to ['receiverOptions'][0]['invoiceData']['item'][0]['identifier']" do
    json["receiverOptions"][0]["invoiceData"]["item"][0]["identifier"].should == "ident123"
  end

  it "maps #receiver_options.first.invoice_data.items.first.price to ['receiverOptions'][0]['invoiceData']['item'][0]['price']" do
    json["receiverOptions"][0]["invoiceData"]["item"][0]["price"].should == "20.00"
  end

  it "maps #receiver_options.first.invoice_data.items.first.item_price to ['receiverOptions'][0]['invoiceData']['item'][0]['itemPrice']" do
    json["receiverOptions"][0]["invoiceData"]["item"][0]["itemPrice"].should == "10.00"
  end

  it "maps #receiver_options.first.invoice_data.items.first.item_count to ['receiverOptions'][0]['invoiceData']['item'][0]['itemCount']" do
    json["receiverOptions"][0]["invoiceData"]["item"][0]["itemCount"].should == 2
  end
end
