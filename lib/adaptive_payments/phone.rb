module AdaptivePayments
  module Phone
    def self.included(base)
      base.instance_eval do
        attribute :phone_country_code, String, :param => "phone.countryCode"
        attribute :phone_number,       String, :param => "phone.phoneNumber"
        attribute :phone_extension,    String, :param => "phone.extension"
      end
    end
  end
end
