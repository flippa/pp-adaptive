require "spec_helper"

shared_examples "a RequestEnvelope" do
  let(:request) { described_class.new(:detail_level => "ReturnAll") }

  it "maps #detail_level to 'requestEnvelope.detailLevel'" do
    request.to_hash["requestEnvelope.detailLevel"].should == "ReturnAll"
  end

  it "includes 'en_US' as the 'errorLanguage'" do
    request.to_hash["requestEnvelope.errorLanguage"].should == "en_US"
  end
end
