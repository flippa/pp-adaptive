require "spec_helper"

describe AdaptivePayments::PreapprovalRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::PreapprovalRequest }
  its(:operation) { should == :Preapproval }

  let(:request) do
    AdaptivePayments::PreapprovalRequest.new(
      :ending_date              => DateTime.new(2011, 9, 20, 7, 57, 2, Rational(10, 24)),
      :starting_date            => DateTime.new(2011, 9, 20, 7, 49, 2, Rational(5, 24)),
      :max_total_amount         => 720,
      :currency_code            => "USD",
      :cancel_url               => "http://site.com/cancelled",
      :return_url               => "http://site.com/succeeded",
      :ipn_notification_url     => "http://site.com/ipn",
      :date_of_month            => 15,
      :day_of_week              => "friday",
      :max_amount_per_payment   => 60,
      :max_payments             => 12,
      :max_payments_per_period  => 1,
      :payment_period           => "monthly",
      :memo                     => "some memo",
      :sender_email             => "sender@site.com",
      :pin_type                 => "required",
      :fees_payer               => "sender",
      :display_max_total_amount => false
    )
  end

  it "maps #ending_date to 'endingDate'" do
    request.to_hash["endingDate"].should == "2011-09-20T07:57:02+10:00"
  end

  it "maps #starting_date to 'startingDate'" do
    request.to_hash["startingDate"].should == "2011-09-20T07:49:02+05:00"
  end

  it "maps #max_total_amount to 'maxTotalAmountOfAllPayments'" do
    request.to_hash["maxTotalAmountOfAllPayments"].should == "720.00"
  end

  it "maps #currency_code to 'currencyCode'" do
    request.to_hash["currencyCode"].should == "USD"
  end

  it "maps #cancel_url to 'cancelUrl'" do
    request.to_hash["cancelUrl"].should == "http://site.com/cancelled"
  end

  it "maps #return_url to 'returnUrl'" do
    request.to_hash["returnUrl"].should == "http://site.com/succeeded"
  end

  it "maps #ipn_notification_url to 'ipnNotificationUrl'" do
    request.to_hash["ipnNotificationUrl"].should == "http://site.com/ipn"
  end

  it "maps #date_of_month to 'dateOfMonth'" do
    request.to_hash["dateOfMonth"].should == "15"
  end

  it "maps #day_of_week to 'dayOfWeek'" do
    request.to_hash["dayOfWeek"].should == "friday"
  end

  it "maps #max_amount_per_payment to 'maxAmountPerPayment'" do
    request.to_hash["maxAmountPerPayment"].should == "60.00"
  end

  it "maps #max_payments to 'maxNumberOfPayments'" do
    request.to_hash["maxNumberOfPayments"].should == "12"
  end

  it "maps #max_payments_per_period to 'maxNumberOfPaymentsPerPeriod'" do
    request.to_hash["maxNumberOfPaymentsPerPeriod"].should == "1"
  end

  it "maps #payment_period to 'paymentPeriod'" do
    request.to_hash["paymentPeriod"].should == "monthly"
  end

  it "maps #memo to 'memo'" do
    request.to_hash["memo"].should == "some memo"
  end

  it "maps #sender_email to 'senderEmail'" do
    request.to_hash["senderEmail"].should == "sender@site.com"
  end

  it "maps #pin_type to 'pinType'" do
    request.to_hash["pinType"].should == "required"
  end

  it "maps #fees_payer to 'feesPayer'" do
    request.to_hash["feesPayer"].should == "sender"
  end

  it "maps #display_max_total_amount to 'displayMaxTotalAmount'" do
    request.to_hash["displayMaxTotalAmount"].should == "false"
  end

  it "does not include omitted parameters" do
    request.max_amount_per_payment = nil
    request.to_hash.should_not have_key("maxAmountPerPayment")
  end
end
