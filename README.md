# A Ruby API for PayPal Adaptive Payments

  - Current Status: Work-in-progress (don't use, API subject to major change)
  - Working:
    - setting up an explicit preapproval
    - processing payments (for an explicit preapproval)
  - Not working:
    - executing pre-created payments
    - changing options on a created payment
    - refunds/cancellations
    - minor things like currency conversion requests

This gem provides access to PayPal's Adaptive Payments API using easy-to-use
ruby classes.  The internals are largely backed by
[Virtus](https://github.com/solnic/virtus) and
[RestClient](https://github.com/archiloque/rest-client), and so are easy to
work with.

## Installing the Gem

Via rubygems:

    gem install pp-adaptive

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
