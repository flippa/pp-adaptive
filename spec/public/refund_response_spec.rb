require "spec_helper"

describe AdaptivePayments::RefundResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"

  let(:response) do
    AdaptivePayments::RefundResponse.from_json(
      {
        :currencyCode   => "GBP",
        :refundInfoList => {
          :refundInfo => [
            {
              :receiver => {
                :email     => "bob@site.com",
                :amount    => "20.00",
                :invoiceId => "77"
              },
              :refundStatus                  => "Pending",
              :refundNetAmount               => "19.20",
              :refundFeeAmount               => "0.80",
              :refundGrossAmount             => "20.00",
              :totalOfAllRefunds             => "20.00",
              :refundHasBecomeFull           => true,
              :encryptedRefundTransactionId  => "abc123",
              :refundTransactionStatus       => "Pending",
              :errorList => {
                :error => [
                  {
                    :errorId => "err123",
                    :domain  => "APPLICATION"
                  }
                ]
              }
            },
            {
              :receiver => {
                :amount      => "10.00",
                :paymentType => "DIGITALGOODS"
              },
              :refundStatus => "Completed"
            }
          ]
        }
      }.to_json
    )
  end

  it "maps ['currencyCode'] to #currency_code" do
    response.currency_code.should == "GBP"
  end

  it "maps ['refundInfoList']['refundInfo'][0]['receiver']['email'] to #refund_info.first.receiver_email" do
    response.refund_info.first.receiver_email.should == "bob@site.com"
  end

  it "maps ['refundInfoList']['refundInfo'][0]['receiver']['amount'] to #refund_info.first.receiver_amount" do
    response.refund_info.first.receiver_amount.should == BigDecimal("20.00")
  end

  it "maps ['refundInfoList']['refundInfo'][0]['receiver']['invoiceId'] to #refund_info.first.invoice_id" do
    response.refund_info.first.invoice_id.should == "77"
  end

  it "maps ['refundInfoList']['refundInfo'][1]['receiver']['amount'] to #refund_info.last.receiver_amount" do
    response.refund_info.last.receiver_amount.should == BigDecimal("10.00")
  end

  it "maps ['refundInfoList']['refundInfo'][1]['receiver']['paymentType'] to #refund_info.last.payment_type" do
    response.refund_info.last.payment_type.should == "DIGITALGOODS"
  end

  it "maps ['refundInfoList']['refundInfo'][0]['refundStatus'] to #refund_info.first.refund_status" do
    response.refund_info.first.refund_status.should == "Pending"
  end

  it "maps ['refundInfoList']['refundInfo'][1]['refundStatus'] to #refund_info.last.refund_status" do
    response.refund_info.last.refund_status.should == "Completed"
  end

  it "maps ['refundInfoList']['refundInfo'][0]['refundNetAmount'] to #refund_info.first.refund_net_amount" do
    response.refund_info.first.refund_net_amount.should == BigDecimal("19.20")
  end

  it "maps ['refundInfoList']['refundInfo'][0]['refundFeeAmount'] to #refund_info.first.refund_fee_amount" do
    response.refund_info.first.refund_fee_amount.should == BigDecimal("0.80")
  end

  it "maps ['refundInfoList']['refundInfo'][0]['refundGrossAmount'] to #refund_info.first.refund_gross_amount" do
    response.refund_info.first.refund_gross_amount.should == BigDecimal("20.00")
  end

  it "maps ['refundInfoList']['refundInfo'][0]['totalOfAllRefunds'] to #refund_info.first.total_of_all_refunds" do
    response.refund_info.first.total_of_all_refunds.should == BigDecimal("20.00")
  end

  it "maps ['refundInfoList']['refundInfo'][0]['refundHasBecomeFull'] to #refund_info.first.refund_has_become_full? " do
    response.refund_info.first.refund_has_become_full?.should be_true
  end

  it "maps ['refundInfoList']['refundInfo'][0]['encryptedRefundTransactionId'] to #refund_info.first.encrypted_refund_transaction_id" do
    response.refund_info.first.encrypted_refund_transaction_id.should == "abc123"
  end

  it "maps ['refundInfoList']['refundInfo'][0]['refundTransactionStatus'] to #refund_info.first.refund_transaction_status" do
    response.refund_info.first.refund_transaction_status.should == "Pending"
  end

  it "maps ['refundInfoList']['refundInfo'][0]['errorList']['error'][0]['errorId'] to #refundInfo.first.errors.first.id" do
    response.refund_info.first.errors.first.id.should == "err123"
  end

  it "maps ['refundInfoList']['refundInfo'][0]['errorList']['error'][0]['domain'] to #refund_info.first.errors.first.domain" do
    response.refund_info.first.errors.first.domain.should == "APPLICATION"
  end
end
