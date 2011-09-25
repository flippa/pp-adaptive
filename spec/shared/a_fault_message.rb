require "spec_helper"

shared_examples "a FaultMessage" do
  let(:response) do
    described_class.from_string([
      "error(0).errorId=1234",
      "error(0).domain=PLATFORM",
      "error(0).subdomain=Application",
      "error(0).severity=Error",
      "error(0).category=Application",
      "error(0).message=An+error+message",
      "error(0).parameter(0)=X-HEADER-FIELD",
      "error(0).parameter(1)=X-OTHER-FIELD",
      "error(1).errorId=2345"
    ].join("&"))
  end

  it "maps 'error(0).errorId' to #error_id" do
    response.error_id.should == 1234
  end

  it "maps 'error(0).domain' to #error_domain" do
    response.error_domain.should == "PLATFORM"
  end

  it "maps 'error(0).subdomain' to #error_subdomain" do
    response.error_subdomain.should == "Application"
  end

  it "maps 'error(0).severity' to #error_severity" do
    response.error_severity.should == "Error"
  end

  it "maps 'error(0).category' to #error_category" do
    response.error_category.should == "Application"
  end

  it "maps 'error(0).message' to #error_message" do
    response.error_message.should == "An error message"
  end

  it "maps 'error(0).parameter(0)' to #error_parameters.first" do
    response.error_parameters.first.should == "X-HEADER-FIELD"
  end

  it "maps 'error(0).parameter(1)' to #error_parameters.last" do
    response.error_parameters.last.should == "X-OTHER-FIELD"
  end

  it "allows access to additional errors via #errors" do
    response.errors.last.id.should == 2345
  end
end
