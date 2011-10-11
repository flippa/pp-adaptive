require "spec_helper"

describe AdaptivePayments::PreapprovalDetailsRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::PreapprovalDetailsRequest }
  its(:operation) { should == :PreapprovalDetails }

  let(:request) do
    AdaptivePayments::PreapprovalDetailsRequest.new(
      :preapproval_key     => "ABCDEFG-1234",
      :get_billing_address => true
    )
  end

  let(:json) { JSON.parse(request.to_json) }

  it "maps #preapproval_key to ['preapprovalKey']" do
    json["preapprovalKey"].should == "ABCDEFG-1234"
  end

  it "maps #get_billing_address to ['getBillingAddress']" do
    json["getBillingAddress"].should == true
  end
end
