require "spec_helper"

describe AdaptivePayments::PreapprovalResponse do
  it_behaves_like "a ResponseEnvelope"
  it_behaves_like "a FaultMessage"

  let(:response) do
    AdaptivePayments::PreapprovalResponse.from_json('{"preapprovalKey":"SOME-KEY"}')
  end

  it "maps ['preapprovalKey'] to #preapproval_key" do
    expect(response.preapproval_key).to eq("SOME-KEY")
  end
end
