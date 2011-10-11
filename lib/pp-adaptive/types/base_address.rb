module AdaptivePayments
  class BaseAddress < JsonModel
    attribute :line1,        String
    attribute :line2,        String
    attribute :city,         String
    attribute :state,        String
    attribute :postal_code,  String, :param => "postalCode"
    attribute :country_code, String, :param => "countryCode"
    attribute :type,         String
  end
end
