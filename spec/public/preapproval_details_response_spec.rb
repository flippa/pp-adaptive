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
        :displayMaxTotalAmount       => true
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
end
