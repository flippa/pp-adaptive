require "spec_helper"

describe AdaptivePayments::PreapprovalResponse do
  let(:response) do
    AdaptivePayments::PreapprovalResponse.new(
      "preapprovalKey=SOME-KEY&responseEnvelope.ack=Success&responseEnvelope.build=123456&responseEnvelope.timestamp=2011-09-21T00:00:00+00:00&responseEnvelope.correlationId=1234"
    )
  end

  it "maps 'preapprovalKey' to #preapproval_key" do
    response.preapproval_key.should == "SOME-KEY"
  end

  it "maps 'responseEnvelope.ack' to #ack_code" do
    response.ack_code.should == "Success"
  end

  it "maps 'responseEnvelope.build' to #build" do
    response.build.should == "123456"
  end

  it "maps 'responseEnvelope.timestamp' to #time" do
    response.time.should == DateTime.new(2011, 9, 21)
  end

  it "maps 'responseEnvelope.correlationId' to #correlation_id" do
    response.correlation_id.should == "1234"
  end
end
