require "spec_helper"

shared_examples "a FaultMessage" do
  let(:response) do
    described_class.from_json(
      {
        :error => [
          {
            :errorId   => 1234,
            :domain    => "PLATFORM",
            :subdomain => "Application",
            :severity  => "Error",
            :category  => "Application",
            :message   => "An error message",
            :parameter => ["X-HEADER-FIELD", "X-OTHER-FIELD"]
          },
          {
            :errorId => 2345
          }
        ]
      }.to_json
    )
  end

  it "maps ['error'][0]['errorId'] to #error_id" do
    expect(response.error_id).to eq(1234)
  end

  it "maps ['error'][0]['domain'] to #error_domain" do
    expect(response.error_domain).to eq("PLATFORM")
  end

  it "maps ['error'][0]['subdomain'] to #error_subdomain" do
    expect(response.error_subdomain).to eq("Application")
  end

  it "maps ['error'][0]['severity'] to #error_severity" do
    expect(response.error_severity).to eq("Error")
  end

  it "maps ['error'][0]['category'] to #error_category" do
    expect(response.error_category).to eq("Application")
  end

  it "maps ['error'][0]['message'] to #error_message" do
    expect(response.error_message).to eq("An error message")
  end

  it "maps ['error'][0]['parameter'][0] to #error_parameters.first" do
    expect(response.error_parameters.first).to eq("X-HEADER-FIELD")
  end

  it "maps ['error'][0]['parameter'][1] to #error_parameters.last" do
    expect(response.error_parameters.last).to eq("X-OTHER-FIELD")
  end

  it "allows access to additional errors via #errors" do
    expect(response.errors.last.id).to eq(2345)
  end
end
