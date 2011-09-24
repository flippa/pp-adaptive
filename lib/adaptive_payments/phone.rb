module AdaptivePayments
  module Phone
    class << self
      def included(base)
        base.instance_eval do
          attribute :phone_country_code, String, :param => "phone.countryCode"
          attribute :phone_number,       String, :param => "phone.phoneNumber"
          attribute :phone_extension,    String, :param => "phone.extension"
        end
      end

      alias_method :extended, :included
    end
  end
end
