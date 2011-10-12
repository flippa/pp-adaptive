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
    response.institution_id.should == "inst123"
  end

  it "maps ['initiatingEntity']['institutionCustomer']['firstName'] to #customer_first_name" do
    response.customer_first_name.should == "Bob"
  end

  it "maps ['initiatingEntity']['institutionCustomer']['lastName'] to #customer_last_name" do
    response.customer_last_name.should == "Cat"
  end

  it "maps ['initiatingEntity']['institutionCustomer']['displayName'] to #customer_display_name" do
    response.customer_display_name.should == "Bobcat"
  end

  it "maps ['initiatingEntity']['institutionCustomer']['institutionCustomerId'] to #institution_customer_id" do
    response.institution_customer_id.should == "77"
  end

  it "maps ['initiatingEntity']['institutionCustomer']['countryCode'] to #customer_country_code" do
    response.customer_country_code.should == "AU"
  end

  it "maps ['initiatingEntity']['institutionCustomer']['email'] to #customer_email" do
    response.customer_email.should == "bob@site.com"
  end

  it "maps ['displayOptions']['emailHeaderImageUrl'] to #email_header_image_url" do
    response.email_header_image_url.should == "http://site.com/email.png"
  end

  it "maps ['displayOptions']['emailMarketingImageUrl'] to #email_marketing_image_url" do
    response.email_marketing_image_url.should == "http://site.com/marketing.png"
  end

  it "maps ['displayOptions']['headerImageUrl'] to #header_image_url" do
    response.header_image_url.should == "http://site.com/header.png"
  end

  it "maps ['displayOptions']['businessName'] to #business_na,e" do
    response.business_name.should == "Bobcats R us"
  end

  it "maps ['shippingAddressId'] to #shipping_address_id" do
    response.shipping_address_id.should == "addr123"
  end

  it "maps ['senderOptions']['requireShippingAddressSelection'] to #require_shipping_address_selection? " do
    response.require_shipping_address_selection?.should be_true
  end

  it "maps ['receiverOptions'][0]['description'] to #receiver_options.first.description" do
    response.receiver_options.first.description.should == "Primary receiver"
  end

  it "maps ['receiverOptions'][0]['customId'] to #receiver_options.first.custom_id" do
    response.receiver_options.first.custom_id.should == "cust123"
  end

  it "maps ['receiverOptions'][0]['invoiceData']['totalTax'] to #receiver_options.first.invoice_data.total_tax" do
    response.receiver_options.first.invoice_data.total_tax.should == BigDecimal("2.00")
  end

  it "maps ['receiverOptions'][0]['invoiceData']['totalShipping'] to #receiver_options.first.invoice_data.total_shipping" do
    response.receiver_options.first.invoice_data.total_shipping.should == BigDecimal("0.00")
  end

  it "maps ['receiverOptions'][0]['invoiceData']['item'][0]['name'] to #receiver_options.first.invoice_data.items.first.name" do
    response.receiver_options.first.invoice_data.items.first.name.should == "Video Game"
  end

  it "maps ['receiverOptions'][0]['invoiceData']['item'][0]['identifier'] to #receiver_options.first.invoice_data.items.first.identifier" do
    response.receiver_options.first.invoice_data.items.first.identifier.should == "ident123"
  end

  it "maps ['receiverOptions'][0]['invoiceData']['item'][0]['price'] to #receiver_options.first.invoice_data.items.first.price" do
    response.receiver_options.first.invoice_data.items.first.price.should == BigDecimal("20.00")
  end

  it "maps ['receiverOptions'][0]['invoiceData']['item'][0]['itemPrice'] to #receiver_options.first.invoice_data.items.first.item_price" do
    response.receiver_options.first.invoice_data.items.first.item_price.should == BigDecimal("10.00")
  end

  it "maps ['receiverOptions'][0]['invoiceData']['item'][0]['itemCount'] to #receiver_options.first.invoice_data.items.first.item_count" do
    response.receiver_options.first.invoice_data.items.first.item_count.should == 2
  end
end
