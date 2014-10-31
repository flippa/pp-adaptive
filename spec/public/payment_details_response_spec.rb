require "spec_helper"

describe AdaptivePayments::PaymentDetailsResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"

  let(:response) do
    AdaptivePayments::PaymentDetailsResponse.from_json(
      {
        :cancelUrl          => "http://site.com/cancelled",
        :returnUrl          => "http://site.com/success",
        :ipnNotificationUrl => "http://site.com/ipn",
        :memo               => "a note to self",
        :currencyCode       => "AUD",
        :paymentInfoList    => {
          :paymentInfo => [
            {
              :transactionId           => "ABC123",
              :transactionStatus       => "Completed",
              :receiver => {
                :email          => "bob@site.com",
                :amount         => "20.00",
                :paymentType    => "DIGITALGOODS",
                :paymentSubType => "SOFTWARE",
                :invoiceId      => "77"
              },
              :refundedAmount          => "0.00",
              :pendingRefund           => true,
              :senderTransactionId     => "66",
              :senderTransactionStatus => "Completed",
              :pendingReason           => "none"
            },
            {
              :transactionId           => "ABC456",
              :transactionStatus       => "Pending",
              :receiver => {
                :email          => "another@site.com",
                :amount         => "10.00",
              },
              :pendingReason           => "anything"
            }
          ]
        },
        :status             => "Completed",
        :trackingId         => "tracking123",
        :payKey             => "pay123",
        :actionType         => "PAY",
        :feesPayer          => "SENDER",
        :reverseAllParallelPaymentsOnError => true,
        :preapprovalKey     => "PREAPP123",
        :fundingConstraint  => {
          :allowedFundingType => {
            :fundingTypeInfo => [
              {
                :fundingType => "CREDITCARD"
              },
              {
                :fundingType => "BALANCE"
              }
            ]
          }
        },
        :sender             => {
          :email          => "sender@site.com",
          :useCredentials => false,
          :phone          => {
            :countryCode => "1",
            :phoneNumber => "456789123",
            :extension   => "444"
          }
        }
      }.to_json
    )
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

  it "maps ['memo'] to #memo" do
    expect(response.memo).to eq("a note to self")
  end

  it "maps ['currencyCode'] to #currencyCode" do
    expect(response.currency_code).to eq("AUD")
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['transactionId'] to #payments.first.transaction_id" do
    expect(response.payments.first.transaction_id).to eq("ABC123")
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['transactionStatus'] to #payments.first.transaction_status" do
    expect(response.payments.first.transaction_status).to eq("Completed")
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['receiver']['email'] to #payments.first.receiver_email" do
    expect(response.payments.first.receiver_email).to eq("bob@site.com")
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['receiver']['amount'] to #payments.first.receiver_amount" do
    expect(response.payments.first.receiver_amount).to eq(BigDecimal("20.00"))
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['receiver']['paymentType'] to #payments.first.payment_type" do
    expect(response.payments.first.payment_type).to eq("DIGITALGOODS")
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['receiver']['paymentSubType'] to #payments.first.payment_subtype" do
    expect(response.payments.first.payment_subtype).to eq("SOFTWARE")
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['receiver']['invoiceId'] to #payments.first.invoice_id" do
    expect(response.payments.first.invoice_id).to eq("77")
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['refundedAmount'] to #payments.first.refunded_amount" do
    expect(response.payments.first.refunded_amount).to eq(BigDecimal("0.00"))
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['pendingRefund'] to #payments.first.pending_refund? " do
    expect(response.payments.first).to be_pending_refund
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['senderTransactionId'] to #payments.first.sender_transaction_id" do
    expect(response.payments.first.sender_transaction_id).to eq("66")
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['senderTransactionStatus'] to #payments.first.sender_transaction_status" do
    expect(response.payments.first.sender_transaction_status).to eq("Completed")
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['pendingReason'] to #payments.first.pending_reason" do
    expect(response.payments.first.pending_reason).to eq("none")
  end

  it "maps ['paymentInfoList']['paymentInfo'][1]['transactionId'] to #payments.last.transaction_id" do
    expect(response.payments.last.transaction_id).to eq("ABC456")
  end

  it "maps ['paymentInfoList']['paymentInfo'][1]['transactionStatus'] to #payments.last.transaction_status" do
    expect(response.payments.last.transaction_status).to eq("Pending")
  end

  it "maps ['paymentInfoList']['paymentInfo'][1]['receiver']['email'] to #payments.last.receiver_email" do
    expect(response.payments.last.receiver_email).to eq("another@site.com")
  end

  it "maps ['status'] to #status" do
    expect(response.status).to eq("Completed")
  end

  it "maps ['trackingId'] to #tracking_id" do
    expect(response.tracking_id).to eq("tracking123")
  end

  it "maps ['payKey'] to #pay_key" do
    expect(response.pay_key).to eq("pay123")
  end

  it "maps ['actionType'] to #actionType" do
    expect(response.action_type).to eq("PAY")
  end

  it "maps ['feesPayer'] to #fees_payer" do
    expect(response.fees_payer).to eq("SENDER")
  end

  it "maps ['reverseAllParallelPaymentsOnError'] to #reverse_parallel_payments_on_error? " do
    expect(response.reverse_parallel_payments_on_error?).to be_truthy
  end

  it "maps ['preapprovalKey'] to #preapproval_key" do
    expect(response.preapproval_key).to eq("PREAPP123")
  end

  it "maps ['fundingConstraint']['allowedFundingType']['fundingTypeInfo'][0]['fundingType'] to #allowed_funding_types.first" do
    expect(response.allowed_funding_types.first).to eq("CREDITCARD")
  end

  it "maps ['fundingConstraint']['allowedFundingType']['fundingTypeInfo'][1]['fundingType'] to #allowed_funding_types.last" do
    expect(response.allowed_funding_types.last).to eq("BALANCE")
  end

  it "maps ['sender']['email'] to #sender_email" do
    expect(response.sender_email).to eq("sender@site.com")
  end

  it "maps ['sender']['useCredentials'] to #use_sender_credentials? " do
    expect(response.use_sender_credentials?).to be_falsey
  end

  it "maps ['sender']['phone']['countryCode'] to #sender_phone_country_code" do
    expect(response.sender_phone_country_code).to eq("1")
  end

  it "maps ['sender']['phone']['phoneNumber'] to #sender_phone_number" do
    expect(response.sender_phone_number).to eq("456789123")
  end

  it "maps ['sender']['phone']['extension'] to #sender_phone_extension" do
    expect(response.sender_phone_extension).to eq("444")
  end
end
