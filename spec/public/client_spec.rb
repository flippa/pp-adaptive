require "spec_helper"

describe AdaptivePayments::Client do
  let(:rest_client)   { double(:post => '{}').tap { |d| allow(d).to receive_messages(:[] => d) } }
  let(:request_class) { double(:operation => :Refund, :build_response => nil) }
  let(:request)       { double(:class => request_class, :to_json => '{}') }
  let(:client)        { AdaptivePayments::Client.new }

  before(:each) do
    allow(RestClient::Resource).to receive(:new).and_return(rest_client)
  end

  it "uses the production endpoint by default" do
    expect(RestClient::Resource).to receive(:new) \
      .with("https://svcs.paypal.com/AdaptivePayments", an_instance_of(Hash)) \
      .and_return(rest_client)
    client.execute(request)
  end

  it "uses the sandbox when sandbox? is true" do
    client.sandbox = true
    expect(RestClient::Resource).to receive(:new) \
      .with("https://svcs.sandbox.paypal.com/AdaptivePayments", an_instance_of(Hash)) \
      .and_return(rest_client)
    client.execute(request)
  end

  it "sends the user ID in the headers to the endpoint" do
    client.user_id = "a.user.id"
    expect(RestClient::Resource).to receive(:new) \
      .with(/^https:\/\/.*/, :headers => hash_including("X-PAYPAL-SECURITY-USERID" => "a.user.id")) \
      .and_return(rest_client)
    client.execute(request)
  end

  it "sends the password in the headers to the endpoint" do
    client.password = "123456"
    expect(RestClient::Resource).to receive(:new) \
      .with(/^https:\/\/.*/, :headers => hash_including("X-PAYPAL-SECURITY-PASSWORD" => "123456")) \
      .and_return(rest_client)
    client.execute(request)
  end

  it "sends the signature in the headers to the endpoint" do
    client.signature = "a.signature"
    expect(RestClient::Resource).to receive(:new) \
      .with(/^https:\/\/.*/, :headers => hash_including("X-PAYPAL-SECURITY-SIGNATURE" => "a.signature")) \
      .and_return(rest_client)
    client.execute(request)
  end

  it "sends the application ID in the headers to the endpoint" do
    client.app_id = "an.app.id"
    expect(RestClient::Resource).to receive(:new) \
      .with(/^https:\/\/.*/, :headers => hash_including("X-PAYPAL-APPLICATION-ID" => "an.app.id")) \
      .and_return(rest_client)
    client.execute(request)
  end

  it "sets the request format to JSON" do
    expect(RestClient::Resource).to receive(:new) \
      .with(/^https:\/\/.*/, :headers => hash_including("X-PAYPAL-REQUEST-DATA-FORMAT" => "JSON")) \
      .and_return(rest_client)
    client.execute(request)
  end

  it "sets the response format to JSON" do
    expect(RestClient::Resource).to receive(:new) \
      .with(/^https:\/\/.*/, :headers => hash_including("X-PAYPAL-RESPONSE-DATA-FORMAT" => "JSON")) \
      .and_return(rest_client)
    client.execute(request)
  end

  it "sends requests to the given API operation" do
    allow(request.class).to receive_messages(:operation => :Preapproval)
    expect(rest_client).to receive(:[]).with("Preapproval")
    client.execute(request)
  end

  it "uses the request class to build a response" do
    response = double(:response)
    expect(request_class).to receive(:build_response).and_return(response)
    expect(client.execute(request)).to eq(response)
  end

  it "allows passing a Symbol + Hash instead of a full request object" do
    expect(client.execute(:Refund, {})).to be_a_kind_of(AdaptivePayments::RefundResponse)
  end

  it "yields the response object" do
    response = double(:response)
    expect(request_class).to receive(:build_response).and_return(response)
    ret_val = nil
    client.execute(request) { |r| ret_val = r }
    expect(ret_val).to eq(response)
  end
end
