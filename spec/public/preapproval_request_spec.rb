require "spec_helper"

describe AdaptivePayments::PreapprovalRequest do
  subject         { AdaptivePayments::PreapprovalRequest }
  its(:operation) { should == :Preapproval }

  let(:request) do
    AdaptivePayments::PreapprovalRequest.new(
      :ending_date      => DateTime.new(2011, 9, 20, 7, 57, 2, Rational(10, 24)),
      :starting_date    => DateTime.new(2011, 9, 20, 7, 49, 2, Rational(5, 24)),
      :max_total_amount => 720,
      :currency_code    => "USD",
      :cancel_url       => "http://site.com/cancelled",
      :return_url       => "http://site.com/succeeded"
    )
  end

  it "maps #ending_date to 'endingDate'" do
    request.to_hash["endingDate"].should == "2011-09-20T07:57:02+10:00"
  end

  it "maps #starting_date to 'startingDate'" do
    request.to_hash["startingDate"].should == "2011-09-20T07:49:02+05:00"
  end

  it "maps #max_total_amount to 'maxTotalAmountOfAllPayments'" do
    request.to_hash["maxTotalAmountOfAllPayments"].should == "720.00"
  end

  it "maps #currency_code to 'currencyCode'" do
    request.to_hash["currencyCode"].should == "USD"
  end

  it "maps #cancel_url to 'cancelUrl'" do
    request.to_hash["cancelUrl"].should == "http://site.com/cancelled"
  end

  it "maps #return_url to 'returnUrl'" do
    request.to_hash["returnUrl"].should == "http://site.com/succeeded"
  end

  it "includes 'en_US' as the 'errorLanguage'" do
    request.to_hash["requestEnvelope.errorLanguage"].should == "en_US"
  end

=begin
  specify do
    client = AdaptivePayments::Client.new(
      :user_id   => "flippa_1315388651_biz_api1.w3style.co.uk",
      :password  => "1315388689",
      :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31ASlDO-TqoptjRqW7Zoce9M6ujYrE",
      :app_id    => "APP-80W284485P519543T",
      :device_ip => "127.0.0.1",
      :sandbox   => true
    )

    request = AdaptivePayments::PreapprovalRequest.new(
      :ending_date      => DateTime.now + 365,
      :starting_date    => DateTime.now,
      :max_total_amount => 720,
      :currency_code    => "USD",
      :cancel_url       => "https://flippa.chris.vm/",
      :return_url       => "https://flippa.chris.vm/",
      :error_language   => "en_US"
    )

    puts client.execute(request)
  end
=end
end
