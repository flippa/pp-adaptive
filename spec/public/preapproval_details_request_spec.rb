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

  it "maps #preapproval_key to 'preapprovalKey'" do
    request.to_hash["preapprovalKey"].should == "ABCDEFG-1234"
  end

  it "maps #get_billing_address to 'getBillingAddress'" do
    request.to_hash["getBillingAddress"].should == "true"
  end
end
