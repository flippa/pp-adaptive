require "spec_helper"

describe AdaptivePayments::ConvertCurrencyResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"

  let(:response) do
    AdaptivePayments::ConvertCurrencyResponse.from_json(
      {
        :estimatedAmountTable => {
          :currencyConversionList => [
            {
              :baseAmount => {
                :code   => "USD",
                :amount => "14.99"
              },
              :currencyList => {
                :currency => [
                  {
                    :code   => "JPY",
                    :amount => "1733"
                  }
                ]
              }
            },
            {
              :baseAmount => {
                :code   => "USD",
                :amount => "129.99"
              },
              :currencyList => {
                :currency => [
                  {
                    :code   => "JPY",
                    :amount => "15036"
                  }
                ]
              }
            }
          ]
        }
      }.to_json
    )
  end

  it "maps ['estimatedAmountTable']['currencyConversionList']['baseAmount']['code'] to #currency_conversions[0].base_currency_code" do
    expect(response.currency_conversions.first.base_currency_code).to eq("USD")
  end

  it "maps ['estimatedAmountTable']['currencyConversionList']['baseAmount']['amount'] to #currency_conversions[0].base_currency_amount" do
    expect(response.currency_conversions.first.base_currency_amount).to eq(BigDecimal.new("14.99"))
  end

  it "maps ['estimatedAmountTable']['currencyConversionList']['currencyList']['currency][0]['code'] to #currency_conversions[0].currencies[0].currency_code" do
    expect(response.currency_conversions.first.currencies.first.code).to eq("JPY")
  end

  it "maps ['estimatedAmountTable']['currencyConversionList']['currencyList']['currency][0]['amount'] to #currency_conversions[0].currencies[0].currency_amount" do
    expect(response.currency_conversions.first.currencies.first.amount).to eq(BigDecimal.new("1733"))
  end

end
