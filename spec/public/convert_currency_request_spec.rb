require "spec_helper"

describe AdaptivePayments::ConvertCurrencyRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::ConvertCurrencyRequest }

  describe '#operation' do
    subject { super().operation }
    it { is_expected.to eq(:ConvertCurrency) }
  end

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
    expect(json["baseAmountList"]["currency"][0]["amount"]).to eq("14.99")
  end

  it "maps #currency.first.amount to ['baseAmountList']['currency'][1]['amount']" do
    expect(json["baseAmountList"]["currency"][1]["amount"]).to eq("129.99")
  end

end
