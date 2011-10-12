require "spec_helper"

describe AdaptivePayments::GetPaymentOptionsResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"

  let(:response) do
    AdaptivePayments::GetPaymentOptionsResponse.from_json(
      {
        :shippingAddressId => "addr123"
      }.to_json
    )
  end

  it "maps ['shippingAddressId'] to #shipping_address_id" do
    response.shipping_address_id.should == "addr123"
  end
end
