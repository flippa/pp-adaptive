require "rest-client"
require "virtus"

module AdaptivePayments
  class Client
    include Virtus

    attribute :user_id,   String, :header => "X-PAYPAL-SECURITY-USERID"
    attribute :password,  String, :header => "X-PAYPAL-SECURITY-PASSWORD"
    attribute :signature, String, :header => "X-PAYPAL-SECURITY-SIGNATURE"
    attribute :app_id,    String, :header => "X-PAYPAL-APPLICATION-ID"
    attribute :device_ip, String, :header => "X-PAYPAL-DEVICE-IPADDRESS"

    def initialize(options = {})
      super
      self.sandbox = options[:sandbox]
    end

    def sandbox=(flag)
      @sandbox = !!flag
    end

    def sandbox?
      !!@sandbox
    end

    def execute(request)
      base_url = if sandbox?
        "https://svcs.sandbox.paypal.com/AdaptivePayments"
      else
        "https://svcs.paypal.com/AdaptivePayments"
      end

      resource = RestClient::Resource.new(base_url, :headers => headers)
      response = resource[request.class.operation.to_s].post(
        request.to_json,
        :content_type => :json,
        :accept       => :json
      )
      request.class.build_response(response)
    end

    private

    def headers
      base_headers = {
        "X-PAYPAL-RESPONSE-DATA-FORMAT" => "JSON",
        "X-PAYPAL-REQUEST-DATA-FORMAT"  => "JSON"
      }
      attributes.inject(base_headers) do |hash, (attr, value)|
        next hash if value.nil?
        hash.merge(self.class.attributes[attr].options[:header] => value)
      end
    end
  end
end
