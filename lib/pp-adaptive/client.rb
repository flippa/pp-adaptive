require "rest-client"
require "virtus"

module AdaptivePayments
  # The principle hub through which all requests and responses are passed.
  class Client
    include Virtus

    attribute :user_id,   String, :header => "X-PAYPAL-SECURITY-USERID"
    attribute :password,  String, :header => "X-PAYPAL-SECURITY-PASSWORD"
    attribute :signature, String, :header => "X-PAYPAL-SECURITY-SIGNATURE"
    attribute :app_id,    String, :header => "X-PAYPAL-APPLICATION-ID"
    attribute :device_ip, String, :header => "X-PAYPAL-DEVICE-IPADDRESS"

    # Initialize the client with the given options.
    #
    # Options can also be passed via the accessors, if prefered.
    #
    # @option [String] user_id
    #   the adaptive payments API user id
    #
    # @option [String] password
    #   the adaptive payments API password
    #
    # @option [String] signature
    #   the adaptive payments API signature
    #
    # @option [String] app_id
    #   the app ID given to use adaptive payments
    #
    # @option [String] device_ip
    #   the IP address of the user, optional
    #
    # @option [Boolean] sandbox
    #   true if using the sandbox, not production
    def initialize(options = {})
      super
      self.sandbox = options[:sandbox]
    end

    # Turn on/off sandbox mode.
    def sandbox=(flag)
      @sandbox = !!flag
    end

    # Test if the client is using the sandbox.
    #
    # @return [Boolean]
    #   true if using the sandbox
    def sandbox?
      !!@sandbox
    end

    # Execute a Request.
    #
    # @example
    #   response = client.execute(:Refund, pay_key: "abc", amount: 42)
    #   puts response.ack_code
    #
    # @params [Symbol] operation_name
    #   The name of the operation to perform.
    #   This maps with the name of the Request class.
    #
    # @params [Hash] attributes
    #   attributes used to build the request
    #
    # @return [AbstractResponse]
    #   a response object for the given operation
    #
    # @yield [AbstractResponse]
    #   optional way to receive the return value
    def execute(*args)
      request =
        case args.size
        when 1 then args[0]
        when 2 then AbstractRequest.for_operation(args[0]).new(args[1])
        else
          raise ArgumentError, "Invalid arguments: #{args.size} for (1..2)"
        end

      resource = RestClient::Resource.new(api_url, :headers => headers)
      response = resource[request.class.operation.to_s].post(
        request.to_json,
        :content_type => :json,
        :accept       => :json
      )
      request.class.build_response(response).tap do |res|
        yield res if block_given?
      end
    rescue RestClient::Exception => e
      raise AdaptivePayments::Exception, e
    end

    # When initiating a preapproval, get the URL on paypal.com to send the user to.
    #
    # @param [PreapprovalResponse] response
    #   the response when setting up the preapproval
    #
    # @return [String]
    #   the URL on paypal.com to send the user to
    def preapproval_url(response)
      [
        "https://www.",
        ("sandbox." if sandbox?),
        "paypal.com/webscr?cmd=_ap-preapproval&preapprovalkey=",
        response.preapproval_key
      ].join
    end

    # When initiating a payment, get the URL on paypal.com to send the user to.
    #
    # @param [PayResponse] response
    #   the response when setting up the payment
    #
    # @return [String]
    #   the URL on paypal.com to send the user to
    def payment_url(response)
      [
        "https://www.",
        ("sandbox." if sandbox?),
        "paypal.com/webscr?cmd=_ap-payment&paykey=",
        response.pay_key
      ].join
    end

    private

    def api_url
      [
        "https://svcs.",
        ("sandbox." if sandbox?),
        "paypal.com/AdaptivePayments"
      ].join
    end

    def headers
      base_headers = {
        "X-PAYPAL-RESPONSE-DATA-FORMAT" => "JSON",
        "X-PAYPAL-REQUEST-DATA-FORMAT"  => "JSON"
      }
      attribute_set.inject(base_headers) do |hash, attr|
        next hash if self[attr.name].nil?
        hash.merge(attr.options[:header] => self[attr.name])
      end
    end
  end
end
