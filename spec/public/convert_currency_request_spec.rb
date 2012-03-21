require "spec_helper"

describe AdaptivePayments::ConvertCurrencyRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::ConvertCurrencyRequest }
  its(:operation) { should == :ConvertCurrency }

  let(:request) do
    AdaptivePayments::ConvertCurrencyRequest.new(
      :currencies            => [ { :amount =>  '14.99', :code => 'USD' },
                                  { :amount => '129.99', :code => 'USD' } ],
      :convert_to_currencies => ['JPY'],
      :country_code          => 'JP',
      :conversion_type       => 'SENDER_SIDE'
    )
  end

  let(:json) { JSON.parse(request.to_json) }

  it "maps #currency.first.amount to ['baseAmountList']['currency'][0]['amount']" do
    json["baseAmountList"]["currency"][0]["amount"].should == "14.99"
  end

  it "maps #currency.first.amount to ['baseAmountList']['currency'][1]['amount']" do
    json["baseAmountList"]["currency"][1]["amount"].should == "129.99"
  end

end
