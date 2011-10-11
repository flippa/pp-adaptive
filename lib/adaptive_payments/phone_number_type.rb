module AdaptivePayments
  class PhoneNumberType < JsonModel
    attribute :country_code, String, :param => "countryCode"
    attribute :phone_number, String, :param => "phoneNumber"
    attribute :extension,    String, :param => "extension"
  end
end
