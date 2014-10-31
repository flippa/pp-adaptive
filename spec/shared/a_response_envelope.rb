require "spec_helper"

shared_examples "a ResponseEnvelope" do
  let(:response) do
    described_class.from_json(
      {
        :responseEnvelope => {
          :ack           => "Success",
          :build         => "123456",
          :timestamp     => "2011-09-21T00:00:00+00:00",
          :correlationId => "1234"
        }
      }.to_json
    )
  end

  it "maps ['responseEnvelope']['ack'] to #ack_code" do # 
    expect(response.ack_code).to eq("Success")
  end

  it "maps ['responseEnvelope']['build'] to #build" do
    expect(response.build).to eq("123456")
  end

  it "maps ['responseEnvelope']['timestamp'] to #time" do
    expect(response.time).to eq(DateTime.new(2011, 9, 21))
  end

  it "maps ['responseEnvelope']['correlationId'] to #correlation_id" do
    expect(response.correlation_id).to eq("1234")
  end

  it "provides predicate methods for the ack code" do
    expect(response.success?).to be_truthy
  end
end
