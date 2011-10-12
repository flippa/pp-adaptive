require "spec_helper"

describe AdaptivePayments::RefundResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"

  let(:response) do
    AdaptivePayments::RefundResponse.from_json(
      {
        :currencyCode => "GBP"
      }.to_json
    )
  end

  it "maps ['currencyCode'] to #currency_code" do
    response.currency_code.should == "GBP"
  end

  pending
end
