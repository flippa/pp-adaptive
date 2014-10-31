require "spec_helper"

describe AdaptivePayments::PreapprovalDetailsResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"

  let(:response) do
    AdaptivePayments::PreapprovalDetailsResponse.from_json(
      {
        :approved                    => false,
        :cancelUrl                   => "http://site.com/cancelled",
        :returnUrl                   => "http://site.com/success",
        :ipnNotificationUrl          => "http://site.com/ipn",
        :currencyCode                => "USD",
        :maxTotalAmountOfAllPayments => "680.00",
        :startingDate                => "2011-09-22T12:37:07+00:00",
        :endingDate                  => "2012-09-22T12:37:07+00:00",
        :maxAmountPerPayment         => "60.00",
        :paymentPeriod               => "MONTHLY",
        :curPayments                 => 2,
        :curPaymentsAmount           => "100.00",
        :curPeriodAttempts           => 1,
        :curPeriodEndingDate         => "2011-09-30T12:37:07+00:00",
        :dateOfMonth                 => 15,
        :dayOfWeek                   => "FRIDAY",
        :pinType                     => "NOT_REQUIRED",
        :senderEmail                 => "bob@gmail.com",
        :memo                        => "some memo",
        :status                      => "ACTIVE",
        :feesPayer                   => "SENDER",
        :displayMaxTotalAmount       => true,
        :addressList                 => {
          :address => [
            {
              :addressId      => "abc123",
              :addressee_name => "Bob Cat",
              :base_address   => {
                :line1        => "56 Bobcat St",
                :line2        => "Some estate",
                :city         => "Bobcaton",
                :state        => "BCT",
                :postal_code  => "BC1 BC2",
                :country_code => "BC",
                :type         => "Home"
              }
            },
            {
              :addressId      => "abc456",
              :addressee_name => "Pete Mouse",
              :base_address   => {
                :line1        => "2 Le Hole",
                :city         => "Cheese City",
                :state        => "MCT",
                :postal_code  => "3000",
                :country_code => "MM",
                :type         => "Business"
              }
            }
          ]
        }
      }.to_json
    )
  end

  it "maps ['approved'] to #approved" do
    expect(response.approved).to be_falsey
  end

  it "maps ['cancelUrl'] to #cancel_url" do
    expect(response.cancel_url).to eq("http://site.com/cancelled")
  end

  it "maps ['returnUrl'] to #return_url" do
    expect(response.return_url).to eq("http://site.com/success")
  end

  it "maps ['ipnNotificationUrl'] to #ipn_notification_url" do
    expect(response.ipn_notification_url).to eq("http://site.com/ipn")
  end

  it "maps ['currencyCode'] to #currency_code" do
    expect(response.currency_code).to eq("USD")
  end

  it "maps ['maxTotalAmountOfAllPayments'] to #max_total_amount" do
    expect(response.max_total_amount).to eq(BigDecimal('680.00'))
  end

  it "maps ['startingDate'] to #starting_date" do
    expect(response.starting_date).to eq(DateTime.new(2011, 9, 22, 12, 37, 7))
  end

  it "maps ['endingDate'] to #ending_date" do
    expect(response.ending_date).to eq(DateTime.new(2012, 9, 22, 12, 37, 7))
  end

  it "maps ['maxAmountPerPayment'] to #max_amount_per_payment" do
    expect(response.max_amount_per_payment).to eq(BigDecimal('60.00'))
  end

  it "maps ['paymentPeriod'] to #payment_period" do
    expect(response.payment_period).to eq("MONTHLY")
  end

  it "maps ['curPayments'] to #current_payments" do
    expect(response.current_payments).to eq(2)
  end

  it "maps ['curPaymentsAmount'] to #current_payments_amount" do
    expect(response.current_payments_amount).to eq(BigDecimal('100.00'))
  end

  it "maps ['curPeriodAttempts'] to #current_period_attempts" do
    expect(response.current_period_attempts).to eq(1)
  end

  it "maps ['curPeriodEndingDate'] to #current_period_ending_date" do
    expect(response.current_period_ending_date).to eq(DateTime.new(2011, 9, 30, 12, 37, 7))
  end

  it "maps ['dateOfMonth'] to #date_of_month" do
    expect(response.date_of_month).to eq(15)
  end

  it "maps ['dayOfWeek'] to #day_of_week" do
    expect(response.day_of_week).to eq("FRIDAY")
  end

  it "maps ['pinType'] to #pin_type" do
    expect(response.pin_type).to eq("NOT_REQUIRED")
  end

  it "maps ['senderEmail'] to #sender_email" do
    expect(response.sender_email).to eq("bob@gmail.com")
  end

  it "maps ['memo'] to #memo" do
    expect(response.memo).to eq("some memo")
  end

  it "maps ['status'] to #status" do
    expect(response.status).to eq("ACTIVE")
  end

  it "maps ['feesPayer'] to #fees_payer" do
    expect(response.fees_payer).to eq("SENDER")
  end

  it "maps ['displayMaxTotalAmount'] to #display_max_total_amount? " do
    expect(response.display_max_total_amount).to be_truthy
  end

  it "maps ['addressList']['address'][0]['addressId'] to #addresses.first.id" do
    expect(response.addresses.first.id).to eq("abc123")
  end

  it "maps ['addressList']['address'][0]['addresseeName'] to #addresses.first.addressee_name" do
    expect(response.addresses.first.addressee_name).to eq("Bob Cat")
  end

  it "maps ['addressList']['address'][0]['baseAddress']['line1'] to #addresses.first.line1" do
    expect(response.addresses.first.line1).to eq("56 Bobcat St")
  end

  it "maps ['addressList']['address'][0]['baseAddress']['line2'] to #addresses.first.line2" do
    expect(response.addresses.first.line2).to eq("Some estate")
  end

  it "maps ['addressList']['address'][0]['baseAddress']['city'] to #addresses.first.city" do
    expect(response.addresses.first.city).to eq("Bobcaton")
  end

  it "maps ['addressList']['address'][0]['baseAddress']['state'] to #addresses.first.state" do
    expect(response.addresses.first.state).to eq("BCT")
  end

  it "maps ['addressList']['address'][0]['baseAddress']['postalCode'] to #addresses.first.postal_code" do
    expect(response.addresses.first.postal_code).to eq("BC1 BC2")
  end

  it "maps ['addressList']['address'][0]['baseAddress']['countryCode'] to #addresses.first.country_code" do
    expect(response.addresses.first.country_code).to eq("BC")
  end

  it "maps ['addressList']['address'][0]['baseAddress']['type'] to #addresses.first.type" do
    expect(response.addresses.first.type).to eq("Home")
  end

  it "maps ['addressList']['address'][1]['addressId'] to #addresses.last.id" do
    expect(response.addresses.last.id).to eq("abc456")
  end

  it "maps ['addressList']['address'][1]['addresseeName'] to #addresses.last.addressee_name" do
    expect(response.addresses.last.addressee_name).to eq("Pete Mouse")
  end

  it "maps ['addressList']['address'][1]['baseAddress']['line1'] to #addresses.last.line1" do
    expect(response.addresses.last.line1).to eq("2 Le Hole")
  end
end
