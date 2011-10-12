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
    response.cancel_url.should == "http://site.com/cancelled"
  end

  it "maps ['returnUrl'] to #return_url" do
    response.return_url.should == "http://site.com/success"
  end

  it "maps ['ipnNotificationUrl'] to #ipn_notification_url" do
    response.ipn_notification_url.should == "http://site.com/ipn"
  end

  it "maps ['memo'] to #memo" do
    response.memo.should == "a note to self"
  end

  it "maps ['currencyCode'] to #currencyCode" do
    response.currency_code.should == "AUD"
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['transactionId'] to #payments.first.transaction_id" do
    response.payments.first.transaction_id.should == "ABC123"
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['transactionStatus'] to #payments.first.transaction_status" do
    response.payments.first.transaction_status.should == "Completed"
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['receiver']['email'] to #payments.first.receiver_email" do
    response.payments.first.receiver_email.should == "bob@site.com"
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['receiver']['amount'] to #payments.first.receiver_amount" do
    response.payments.first.receiver_amount.should == BigDecimal("20.00")
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['receiver']['paymentType'] to #payments.first.payment_type" do
    response.payments.first.payment_type.should == "DIGITALGOODS"
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['receiver']['paymentSubType'] to #payments.first.payment_subtype" do
    response.payments.first.payment_subtype.should == "SOFTWARE"
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['receiver']['invoiceId'] to #payments.first.invoice_id" do
    response.payments.first.invoice_id.should == "77"
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['refundedAmount'] to #payments.first.refunded_amount" do
    response.payments.first.refunded_amount.should == BigDecimal("0.00")
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['pendingRefund'] to #payments.first.pending_refund? " do
    response.payments.first.should be_pending_refund
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['senderTransactionId'] to #payments.first.sender_transaction_id" do
    response.payments.first.sender_transaction_id.should == "66"
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['senderTransactionStatus'] to #payments.first.sender_transaction_status" do
    response.payments.first.sender_transaction_status.should == "Completed"
  end

  it "maps ['paymentInfoList']['paymentInfo'][0]['pendingReason'] to #payments.first.pending_reason" do
    response.payments.first.pending_reason.should == "none"
  end

  it "maps ['paymentInfoList']['paymentInfo'][1]['transactionId'] to #payments.last.transaction_id" do
    response.payments.last.transaction_id.should == "ABC456"
  end

  it "maps ['paymentInfoList']['paymentInfo'][1]['transactionStatus'] to #payments.last.transaction_status" do
    response.payments.last.transaction_status.should == "Pending"
  end

  it "maps ['paymentInfoList']['paymentInfo'][1]['receiver']['email'] to #payments.last.receiver_email" do
    response.payments.last.receiver_email.should == "another@site.com"
  end

  it "maps ['status'] to #status" do
    response.status.should == "Completed"
  end

  it "maps ['trackingId'] to #tracking_id" do
    response.tracking_id.should == "tracking123"
  end

  it "maps ['payKey'] to #pay_key" do
    response.pay_key.should == "pay123"
  end

  it "maps ['actionType'] to #actionType" do
    response.action_type.should == "PAY"
  end

  it "maps ['feesPayer'] to #fees_payer" do
    response.fees_payer.should == "SENDER"
  end

  it "maps ['reverseAllParallelPaymentsOnError'] to #reverse_parallel_payments_on_error? " do
    response.reverse_parallel_payments_on_error?.should be_true
  end

  it "maps ['preapprovalKey'] to #preapproval_key" do
    response.preapproval_key.should == "PREAPP123"
  end

  it "maps ['fundingConstraint']['allowedFundingType']['fundingTypeInfo'][0]['fundingType'] to #allowed_funding_types.first" do
    response.allowed_funding_types.first.should == "CREDITCARD"
  end

  it "maps ['fundingConstraint']['allowedFundingType']['fundingTypeInfo'][1]['fundingType'] to #allowed_funding_types.last" do
    response.allowed_funding_types.last.should == "BALANCE"
  end

  it "maps ['sender']['email'] to #sender_email" do
    response.sender_email.should == "sender@site.com"
  end

  it "maps ['sender']['useCredentials'] to #use_sender_credentials? " do
    response.use_sender_credentials?.should be_false
  end

  it "maps ['sender']['phone']['countryCode'] to #sender_phone_country_code" do
    response.sender_phone_country_code.should == "1"
  end

  it "maps ['sender']['phone']['phoneNumber'] to #sender_phone_number" do
    response.sender_phone_number.should == "456789123"
  end

  it "maps ['sender']['phone']['extension'] to #sender_phone_extension" do
    response.sender_phone_extension.should == "444"
  end
end
