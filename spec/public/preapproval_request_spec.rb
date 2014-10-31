require "spec_helper"

describe AdaptivePayments::PreapprovalRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::PreapprovalRequest }

  describe '#operation' do
    subject { super().operation }
    it { is_expected.to eq(:Preapproval) }
  end

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

  let(:json) { JSON.parse(request.to_json) }

  it "maps #ending_date to ['endingDate']" do
    expect(json["endingDate"]).to eq("2011-09-20T07:57:02+10:00")
  end

  it "maps #starting_date to ['startingDate']" do
    expect(json["startingDate"]).to eq("2011-09-20T07:49:02+05:00")
  end

  it "maps #max_total_amount to ['maxTotalAmountOfAllPayments']" do
    expect(json["maxTotalAmountOfAllPayments"]).to eq("720.00")
  end

  it "maps #currency_code to ['currencyCode']" do
    expect(json["currencyCode"]).to eq("USD")
  end

  it "maps #cancel_url to ['cancelUrl']" do
    expect(json["cancelUrl"]).to eq("http://site.com/cancelled")
  end

  it "maps #return_url to ['returnUrl']" do
    expect(json["returnUrl"]).to eq("http://site.com/succeeded")
  end

  it "maps #ipn_notification_url to ['ipnNotificationUrl']" do
    expect(json["ipnNotificationUrl"]).to eq("http://site.com/ipn")
  end

  it "maps #date_of_month to ['dateOfMonth']" do
    expect(json["dateOfMonth"]).to eq(15)
  end

  it "maps #day_of_week to ['dayOfWeek']" do
    expect(json["dayOfWeek"]).to eq("friday")
  end

  it "maps #max_amount_per_payment to ['maxAmountPerPayment']" do
    expect(json["maxAmountPerPayment"]).to eq("60.00")
  end

  it "maps #max_payments to ['maxNumberOfPayments']" do
    expect(json["maxNumberOfPayments"]).to eq(12)
  end

  it "maps #max_payments_per_period to ['maxNumberOfPaymentsPerPeriod']" do
    expect(json["maxNumberOfPaymentsPerPeriod"]).to eq(1)
  end

  it "maps #payment_period to ['paymentPeriod']" do
    expect(json["paymentPeriod"]).to eq("monthly")
  end

  it "maps #memo to ['memo']" do
    expect(json["memo"]).to eq("some memo")
  end

  it "maps #sender_email to ['senderEmail']" do
    expect(json["senderEmail"]).to eq("sender@site.com")
  end

  it "maps #pin_type to ['pinType']" do
    expect(json["pinType"]).to eq("required")
  end

  it "maps #fees_payer to ['feesPayer']" do
    expect(json["feesPayer"]).to eq("sender")
  end

  it "maps #display_max_total_amount to ['displayMaxTotalAmount']" do
    expect(json["displayMaxTotalAmount"]).to eq(false)
  end

  it "does not include omitted parameters" do
    request.max_amount_per_payment = nil
    expect(json).not_to have_key("maxAmountPerPayment")
  end
end
