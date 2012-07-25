# A Ruby API for PayPal Adaptive Payments

This gem provides access to PayPal's Adaptive Payments API using easy-to-use
ruby classes. The internals are largely backed by
[Virtus](https://github.com/solnic/virtus) and
[RestClient](https://github.com/archiloque/rest-client), and so are easy to
work with.

## Installing the Gem

Via rubygems:

    gem install pp-adaptive

All API calls are made by calling `#execute` on the client, with the relevant
request object. Naming conventions have been ruby-ized, but you should just
follow along with the PayPal documentation to understand the inputs and outputs.

Some aliases have been added, to make things simpler.  This documentation is a
work in progress, so it's probably better to browse the source files, which are
effectively models that are declarative in nature.

Some quick examples follow.

## Setting up a Preapproval Agreement

``` ruby
require 'pp-adaptive'

client = AdaptivePayments::Client.new(
  :user_id       => "your-api-user-id",
  :password      => "your-api-password",
  :signature     => "your-api-signature",
  :app_id        => "your-app-id",
  :sandbox       => false
)

response = client.execute(AdaptivePayments::PreapprovalRequest.new(
  :ending_date      => DateTime.now.next_year,
  :starting_date    => DateTime.now,
  :max_total_amount => BigDecimal("950.00"),
  :currency_code    => "USD",
  :cancel_url       => "http://site.com/cancelled",
  :return_url       => "http://site.com/completed"
))

if response.success?
  puts "Preapproval key: #{response.preapproval_key}"
else
  puts "#{response.ack_code}: #{response.error_message}"
end
```

(Work in progress...)
