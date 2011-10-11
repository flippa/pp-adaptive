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
    response.approved.should be_false
  end

  it "maps ['cancelUrl'] to #cancel_url" do
    response.cancel_url.should == "http://site.com/cancelled"
  end

  it "maps ['returnUrl'] to #return_url" do
    response.return_url.should == "http://site.com/success"
  end

  it "maps ['ipnNotificationUrl'] to #ipn_notification_url" do
    response.ipn_notification_url.should == "http://site.com/ipn"
  end

  it "maps ['currencyCode'] to #currency_code" do
    response.currency_code.should == "USD"
  end

  it "maps ['maxTotalAmountOfAllPayments'] to #max_total_amount" do
    response.max_total_amount.should == BigDecimal('680.00')
  end

  it "maps ['startingDate'] to #starting_date" do
    response.starting_date.should == DateTime.new(2011, 9, 22, 12, 37, 7)
  end

  it "maps ['endingDate'] to #ending_date" do
    response.ending_date.should == DateTime.new(2012, 9, 22, 12, 37, 7)
  end

  it "maps ['maxAmountPerPayment'] to #max_amount_per_payment" do
    response.max_amount_per_payment.should == BigDecimal('60.00')
  end

  it "maps ['paymentPeriod'] to #payment_period" do
    response.payment_period.should == "MONTHLY"
  end

  it "maps ['curPayments'] to #current_payments" do
    response.current_payments.should == 2
  end

  it "maps ['curPaymentsAmount'] to #current_payments_amount" do
    response.current_payments_amount.should == BigDecimal('100.00')
  end

  it "maps ['curPeriodAttempts'] to #current_period_attempts" do
    response.current_period_attempts.should == 1
  end

  it "maps ['curPeriodEndingDate'] to #current_period_ending_date" do
    response.current_period_ending_date.should == DateTime.new(2011, 9, 30, 12, 37, 7)
  end

  it "maps ['dateOfMonth'] to #date_of_month" do
    response.date_of_month.should == 15
  end

  it "maps ['dayOfWeek'] to #day_of_week" do
    response.day_of_week.should == "FRIDAY"
  end

  it "maps ['pinType'] to #pin_type" do
    response.pin_type.should == "NOT_REQUIRED"
  end

  it "maps ['senderEmail'] to #sender_email" do
    response.sender_email.should == "bob@gmail.com"
  end

  it "maps ['memo'] to #memo" do
    response.memo.should == "some memo"
  end

  it "maps ['status'] to #status" do
    response.status.should == "ACTIVE"
  end

  it "maps ['feesPayer'] to #fees_payer" do
    response.fees_payer.should == "SENDER"
  end

  it "maps ['displayMaxTotalAmount'] to #display_max_total_amount? " do
    response.display_max_total_amount.should be_true
  end

  it "maps ['addressList']['address'][0]['addressId'] to #addresses.first.id" do
    response.addresses.first.id.should == "abc123"
  end

  it "maps ['addressList']['address'][0]['addresseeName'] to #addresses.first.addressee_name" do
    response.addresses.first.addressee_name.should == "Bob Cat"
  end

  it "maps ['addressList']['address'][0]['baseAddress']['line1'] to #addresses.first.line1" do
    response.addresses.first.line1.should == "56 Bobcat St"
  end

  it "maps ['addressList']['address'][0]['baseAddress']['line2'] to #addresses.first.line2" do
    response.addresses.first.line2.should == "Some estate"
  end

  it "maps ['addressList']['address'][0]['baseAddress']['city'] to #addresses.first.city" do
    response.addresses.first.city.should == "Bobcaton"
  end

  it "maps ['addressList']['address'][0]['baseAddress']['state'] to #addresses.first.state" do
    response.addresses.first.state.should == "BCT"
  end

  it "maps ['addressList']['address'][0]['baseAddress']['postalCode'] to #addresses.first.postal_code" do
    response.addresses.first.postal_code.should == "BC1 BC2"
  end

  it "maps ['addressList']['address'][0]['baseAddress']['countryCode'] to #addresses.first.country_code" do
    response.addresses.first.country_code.should == "BC"
  end

  it "maps ['addressList']['address'][0]['baseAddress']['type'] to #addresses.first.type" do
    response.addresses.first.type.should == "Home"
  end

  it "maps ['addressList']['address'][1]['addressId'] to #addresses.last.id" do
    response.addresses.last.id.should == "abc456"
  end

  it "maps ['addressList']['address'][1]['addresseeName'] to #addresses.last.addressee_name" do
    response.addresses.last.addressee_name.should == "Pete Mouse"
  end

  it "maps ['addressList']['address'][1]['baseAddress']['line1'] to #addresses.last.line1" do
    response.addresses.last.line1.should == "2 Le Hole"
  end
end
