require "spec_helper"

describe AdaptivePayments::SetPaymentOptionsRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::SetPaymentOptionsRequest }

  describe '#operation' do
    subject { super().operation }
    it { is_expected.to eq(:SetPaymentOptions) }
  end

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

  let(:json)  { JSON.parse(request.to_json) }

  it "maps #pay_key to ['payKey']" do
    expect(json["payKey"]).to eq("ABCD-1234")
  end

  it "maps #institution_id to ['initiatingEntity']['institutionCustomer']['institutionId']" do
    expect(json["initiatingEntity"]["institutionCustomer"]["institutionId"]).to eq("inst123")
  end

  it "maps #customer_first_name to ['initiatingEntity']['institutionCustomer']['firstName']" do
    expect(json["initiatingEntity"]["institutionCustomer"]["firstName"]).to eq("Bob")
  end

  it "maps #customer_last_name to ['initiatingEntity']['institutionCustomer']['lastName']" do
    expect(json["initiatingEntity"]["institutionCustomer"]["lastName"]).to eq("Cat")
  end

  it "maps #customer_display_name to ['initiatingEntity']['institutionCustomer']['displayName']" do
    expect(json["initiatingEntity"]["institutionCustomer"]["displayName"]).to eq("Bobcat")
  end

  it "maps #institution_customer_id to ['initiatingEntity']['institutionCustomer']['institutionCustomerId']" do
    expect(json["initiatingEntity"]["institutionCustomer"]["institutionCustomerId"]).to eq("77")
  end

  it "maps #customer_country_code to ['initiatingEntity']['institutionCustomer']['countryCode']" do
    expect(json["initiatingEntity"]["institutionCustomer"]["countryCode"]).to eq("AU")
  end

  it "maps #customer_email to ['initiatingEntity']['institutionCustomer']['email']" do
    expect(json["initiatingEntity"]["institutionCustomer"]["email"]).to eq("bob@site.com")
  end

  it "maps #email_header_image_url to ['displayOptions']['emailHeaderImageUrl']" do
    expect(json["displayOptions"]["emailHeaderImageUrl"]).to eq("http://site.com/email.png")
  end

  it "maps #email_marketing_image_url to ['displayOptions']['emailMarketingImageUrl']" do
    expect(json["displayOptions"]["emailMarketingImageUrl"]).to eq("http://site.com/marketing.png")
  end

  it "maps #header_image_url to ['displayOptions']['headerImageUrl']" do
    expect(json["displayOptions"]["headerImageUrl"]).to eq("http://site.com/header.png")
  end

  it "maps #shipping_address_id to ['shippingAddressId']" do
    expect(json["shippingAddressId"]).to eq("addr123")
  end

  it "maps #require_shipping_address_selection?  to ['senderOptions']['requireShippingAddressSelection']" do
    expect(json["senderOptions"]["requireShippingAddressSelection"]).to be_truthy
  end

  it "maps #receiver_options.first.description to ['receiverOptions'][0]['description']" do
    expect(json["receiverOptions"][0]["description"]).to eq("Primary receiver")
  end

  it "maps #receiver_options.first.custom_id to ['receiverOptions'][0]['customId']" do
    expect(json["receiverOptions"][0]["customId"]).to eq("cust123")
  end

  it "maps #receiver_options.first.invoice_data.total_tax to ['receiverOptions'][0]['invoiceData']['totalTax']" do
    expect(json["receiverOptions"][0]["invoiceData"]["totalTax"]).to eq("2.00")
  end

  it "maps #receiver_options.first.invoice_data.total_shipping to ['receiverOptions'][0]['invoiceData']['totalShipping']" do
    expect(json["receiverOptions"][0]["invoiceData"]["totalShipping"]).to eq("0.00")
  end

  it "maps #receiver_options.first.invoice_data.items.first.name to ['receiverOptions'][0]['invoiceData']['item'][0]['name']" do
    expect(json["receiverOptions"][0]["invoiceData"]["item"][0]["name"]).to eq("Video Game")
  end

  it "maps #receiver_options.first.invoice_data.items.first.identifier to ['receiverOptions'][0]['invoiceData']['item'][0]['identifier']" do
    expect(json["receiverOptions"][0]["invoiceData"]["item"][0]["identifier"]).to eq("ident123")
  end

  it "maps #receiver_options.first.invoice_data.items.first.price to ['receiverOptions'][0]['invoiceData']['item'][0]['price']" do
    expect(json["receiverOptions"][0]["invoiceData"]["item"][0]["price"]).to eq("20.00")
  end

  it "maps #receiver_options.first.invoice_data.items.first.item_price to ['receiverOptions'][0]['invoiceData']['item'][0]['itemPrice']" do
    expect(json["receiverOptions"][0]["invoiceData"]["item"][0]["itemPrice"]).to eq("10.00")
  end

  it "maps #receiver_options.first.invoice_data.items.first.item_count to ['receiverOptions'][0]['invoiceData']['item'][0]['itemCount']" do
    expect(json["receiverOptions"][0]["invoiceData"]["item"][0]["itemCount"]).to eq(2)
  end
end
