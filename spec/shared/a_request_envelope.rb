require "spec_helper"

shared_examples "a RequestEnvelope" do
  let(:request) { described_class.new(:detail_level => "ReturnAll") }
  let(:json)    { JSON.parse(request.to_json) }

  it "maps #detail_level to ['requestEnvelope']['detailLevel']" do
    json["requestEnvelope"]["detailLevel"].should == "ReturnAll"
  end

  it "includes 'en_US' as the ['errorLanguage']" do
    json["requestEnvelope"]["errorLanguage"].should == "en_US"
  end
end
