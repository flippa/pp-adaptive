require "spec_helper"

describe AdaptivePayments::CancelPreapprovalRequest do
  it_behaves_like "a RequestEnvelope"

  subject         { AdaptivePayments::CancelPreapprovalRequest }
  its(:operation) { should == :CancelPreapproval }

  let(:request) { AdaptivePayments::CancelPreapprovalRequest.new(:preapproval_key => "ABCD-1234") }
  let(:json)    { JSON.parse(request.to_json) }

  it "maps #preapproval_key to ['preapprovalKey']" do
    json["preapprovalKey"].should == "ABCD-1234"
  end
end
