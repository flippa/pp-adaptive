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
request type. Naming conventions have been ruby-ized, but you should just
follow along with the PayPal documentation to understand the inputs and outputs.

Some aliases have been added, to make things simpler. Some example scenarios
are outlined below, but due to the size of the API, this README does not aim
in any way to be an exhaustive reproduction of the official Adaptive Payments
documentation. Given the declarative, model-style, nature of the classes in
this gem, it probably makes sense to just browse the source to know what
fields are available.

## Example API calls

The following example should give you enough of an idea to be able to
follow your senses and use this gem in your own applications.

### Taking a regular payment

A typical checkout payment request starts like this.

``` ruby
require "pp-adaptive"

client = AdaptivePayments::Client.new(
  :user_id       => "your-api-user-id",
  :password      => "your-api-password",
  :signature     => "your-api-signature",
  :app_id        => "your-app-id",
  :sandbox       => true
)

client.execute(:Pay,
  :action_type     => "PAY",
  :receiver_email  => "your@email.com",
  :receiver_amount => 50,
  :currency_code   => "USD",
  :cancel_url      => "https://your-site.com/cancel",
  :return_url      => "https://your-site.com/return"
) do |response|

  if response.success?
    puts "Pay key: #{response.pay_key}"

    # send the user to PayPal to make the payment
    # e.g. https://www.sandbox.paypal.com/webscr?cmd=_ap-payment&paykey=abc
    redirect_to client.payment_url(response)
  else
    puts "#{response.ack_code}: #{response.error_message}"
  end

end
```

### Checking the payment status on return

When the customer is sent back from PayPal to your `return_url`, you need to
check if the payment was successful or not.

``` ruby
require "pp-adaptive"

client = AdaptivePayments::Client.new(
  :user_id       => "your-api-user-id",
  :password      => "your-api-password",
  :signature     => "your-api-signature",
  :app_id        => "your-app-id",
  :sandbox       => true
)

client.execute(:PaymentDetails, :pay_key => "pay-key-from-pay-request") do |response|
  if response.success?
    puts "Payment status: #{response.payment_exec_status}"
  else
    puts "#{response.ack_code}: #{response.error_message}"
  end
end
```

### Initiating a chained payment

If you need to take a cut of a payment and forward the remainder onto one
or more other recipients, you use a chained payment. This is just a regular
PayRequest, except it includes multiple receivers, one of which is marked as
'primary'.

``` ruby
require "pp-adaptive"

client = AdaptivePayments::Client.new(
  :user_id       => "your-api-user-id",
  :password      => "your-api-password",
  :signature     => "your-api-signature",
  :app_id        => "your-app-id",
  :sandbox       => true
)

client.execute(:Pay,
  :action_type     => "PAY",
  :currency_code   => "USD",
  :cancel_url      => "https://your-site.com/cancel",
  :return_url      => "https://your-site.com/return",
  :receivers       => [
    { :email => "your@email.com", :amount => 50, :primary => true },
    { :email => "other@site.tld", :amount => 45 }
  ]
) do |response|

  if response.success?
    puts "Pay key: #{response.pay_key}"

    # send the user to PayPal to make the payment
    # e.g. https://www.sandbox.paypal.com/webscr?cmd=_ap-payment&paykey=abc
    redirect_to client.payment_url(response)
  else
    puts "#{response.ack_code}: #{response.error_message}"
  end

end
```

In the above example, you get $5 from the $50 payment, with the remaining $45
going to other@site.tld.

### Setting up a Preapproval Agreement

If you need to be able to take payments from a user's account on-demand, you
get the user to authorize you for preapproved payments.

``` ruby
require "pp-adaptive"

client = AdaptivePayments::Client.new(
  :user_id       => "your-api-user-id",
  :password      => "your-api-password",
  :signature     => "your-api-signature",
  :app_id        => "your-app-id",
  :sandbox       => false
)

client.execute(:Preapproval,
  :ending_date      => DateTime.now.next_year,
  :starting_date    => DateTime.now,
  :max_total_amount => BigDecimal("950.00"),
  :currency_code    => "USD",
  :cancel_url       => "http://site.com/cancelled",
  :return_url       => "http://site.com/completed"
) do |response|
  # you may alternatively pass a PreapprovalRequest instance

  if response.success?
    puts "Preapproval key: #{response.preapproval_key}"

    # send the user to PayPal to give their approval
    # e.g. https://www.paypal.com/webscr?cmd=_ap-preapproval&preapprovalkey=abc
    redirect_to client.preapproval_url(response)
  else
    puts "#{response.ack_code}: #{response.error_message}"
  end

end
```

### Taking a payment using an existing Preapproval

To take a payment from a user who has previously authorized you for preapproved
payments, just pass the `pay_key` in the usual PayRequest.

``` ruby
require "pp-adaptive"

client = AdaptivePayments::Client.new(
  :user_id       => "your-api-user-id",
  :password      => "your-api-password",
  :signature     => "your-api-signature",
  :app_id        => "your-app-id",
  :sandbox       => false
)

client.execute(:Pay,
  :preapproval_key => "existing-preapproval-key",
  :action_type     => "PAY",
  :receiver_email  => "your@email.com",
  :receiver_amount => 50,
  :currency_code   => "USD",
  :cancel_url      => "https://your-site.com/cancel",
  :return_url      => "https://your-site.com/return"
) do |response|

  if response.success?
    puts "Pay key: #{response.pay_key}"
    puts "Status: #{response.payment_exec_status}"
  else
    puts "#{response.ack_code}: #{response.error_message}"
  end

end
```

### Issuing a refund

If you have the pay_key from a previously made payment (up to 60 days), you
can send a RefundRequest.

``` ruby
require "pp-adaptive"

client = AdaptivePayments::Client.new(
  :user_id       => "your-api-user-id",
  :password      => "your-api-password",
  :signature     => "your-api-signature",
  :app_id        => "your-app-id",
  :sandbox       => false
)

client.execute(:Refund, :pay_key => "the-pay-key") do |response|
  if response.success?
    puts "Refund sent"
  else
    puts "#{response.ack_code}: #{response.error_message}"
  end
end
```

You can also do partial refunds by passing an `amount` field in the request.

### Other API calls

Adaptive Payments is a very extensive API with a lot of endpoints and a lot
of fields within each request. It wouldn't be wise to attempt to document them
all here, but the official API documentation covers everything in detail.

https://www.paypalobjects.com/webstatic/en_US/developer/docs/pdf/pp_adaptivepayments.pdf

Just ruby-ize the fields (i.e. underscores, not camel case) and open up the
request/response classes in this repository to get a feel for how this all works.

## Contributors

* [d11wtq](https://github.com/d11wtq)
* [Maxim-Filimonov](https://github.com/Maxim-Filimonov)

## License & Copyright

Copyright © Flippa.com Pty Ltd. Licensed under the MIT license. See the
LICENSE file for details.
