require "spec_helper"

describe AdaptivePayments::GetPaymentOptionsResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"

  let(:response) do
    AdaptivePayments::GetPaymentOptionsResponse.from_json(
      {
        :initiatingEntity  => {
          :institutionCustomer => {
            :institutionId         => "inst123",
            :firstName             => "Bob",
            :lastName              => "Cat",
            :displayName           => "Bobcat",
            :institutionCustomerId => "77",
            :countryCode           => "AU",
            :email                 => "bob@site.com"
          }
        },
        :displayOptions => {
          :emailHeaderImageUrl    => "http://site.com/email.png",
          :emailMarketingImageUrl => "http://site.com/marketing.png",
          :headerImageUrl         => "http://site.com/header.png",
          :businessName           => "Bobcats R us"
        },
        :shippingAddressId => "addr123",
        :senderOptions => {
          :requireShippingAddressSelection => true
        },
        :receiverOptions => [
          {
            :description => "Primary receiver",
            :customId    => "cust123",
            :invoiceData => {
              :item           => [
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
          }
        ]
      }.to_json
    )
  end

  it "maps ['initiatingEntity']['institutionCustomer']['institutionId'] to #institution_id" do
    expect(response.institution_id).to eq("inst123")
  end

  it "maps ['initiatingEntity']['institutionCustomer']['firstName'] to #customer_first_name" do
    expect(response.customer_first_name).to eq("Bob")
  end

  it "maps ['initiatingEntity']['institutionCustomer']['lastName'] to #customer_last_name" do
    expect(response.customer_last_name).to eq("Cat")
  end

  it "maps ['initiatingEntity']['institutionCustomer']['displayName'] to #customer_display_name" do
    expect(response.customer_display_name).to eq("Bobcat")
  end

  it "maps ['initiatingEntity']['institutionCustomer']['institutionCustomerId'] to #institution_customer_id" do
    expect(response.institution_customer_id).to eq("77")
  end

  it "maps ['initiatingEntity']['institutionCustomer']['countryCode'] to #customer_country_code" do
    expect(response.customer_country_code).to eq("AU")
  end

  it "maps ['initiatingEntity']['institutionCustomer']['email'] to #customer_email" do
    expect(response.customer_email).to eq("bob@site.com")
  end

  it "maps ['displayOptions']['emailHeaderImageUrl'] to #email_header_image_url" do
    expect(response.email_header_image_url).to eq("http://site.com/email.png")
  end

  it "maps ['displayOptions']['emailMarketingImageUrl'] to #email_marketing_image_url" do
    expect(response.email_marketing_image_url).to eq("http://site.com/marketing.png")
  end

  it "maps ['displayOptions']['headerImageUrl'] to #header_image_url" do
    expect(response.header_image_url).to eq("http://site.com/header.png")
  end

  it "maps ['displayOptions']['businessName'] to #business_na,e" do
    expect(response.business_name).to eq("Bobcats R us")
  end

  it "maps ['shippingAddressId'] to #shipping_address_id" do
    expect(response.shipping_address_id).to eq("addr123")
  end

  it "maps ['senderOptions']['requireShippingAddressSelection'] to #require_shipping_address_selection? " do
    expect(response.require_shipping_address_selection?).to be_truthy
  end

  it "maps ['receiverOptions'][0]['description'] to #receiver_options.first.description" do
    expect(response.receiver_options.first.description).to eq("Primary receiver")
  end

  it "maps ['receiverOptions'][0]['customId'] to #receiver_options.first.custom_id" do
    expect(response.receiver_options.first.custom_id).to eq("cust123")
  end

  it "maps ['receiverOptions'][0]['invoiceData']['totalTax'] to #receiver_options.first.invoice_data.total_tax" do
    expect(response.receiver_options.first.invoice_data.total_tax).to eq(BigDecimal("2.00"))
  end

  it "maps ['receiverOptions'][0]['invoiceData']['totalShipping'] to #receiver_options.first.invoice_data.total_shipping" do
    expect(response.receiver_options.first.invoice_data.total_shipping).to eq(BigDecimal("0.00"))
  end

  it "maps ['receiverOptions'][0]['invoiceData']['item'][0]['name'] to #receiver_options.first.invoice_data.items.first.name" do
    expect(response.receiver_options.first.invoice_data.items.first.name).to eq("Video Game")
  end

  it "maps ['receiverOptions'][0]['invoiceData']['item'][0]['identifier'] to #receiver_options.first.invoice_data.items.first.identifier" do
    expect(response.receiver_options.first.invoice_data.items.first.identifier).to eq("ident123")
  end

  it "maps ['receiverOptions'][0]['invoiceData']['item'][0]['price'] to #receiver_options.first.invoice_data.items.first.price" do
    expect(response.receiver_options.first.invoice_data.items.first.price).to eq(BigDecimal("20.00"))
  end

  it "maps ['receiverOptions'][0]['invoiceData']['item'][0]['itemPrice'] to #receiver_options.first.invoice_data.items.first.item_price" do
    expect(response.receiver_options.first.invoice_data.items.first.item_price).to eq(BigDecimal("10.00"))
  end

  it "maps ['receiverOptions'][0]['invoiceData']['item'][0]['itemCount'] to #receiver_options.first.invoice_data.items.first.item_count" do
    expect(response.receiver_options.first.invoice_data.items.first.item_count).to eq(2)
  end
end
