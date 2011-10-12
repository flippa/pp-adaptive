module AdaptivePayments
  class InstitutionCustomer < JsonModel
    attribute :institution_id,          String, :param => "institutionId"
    attribute :first_name,              String, :param => "firstName"
    attribute :last_name,               String, :param => "lastName"
    attribute :display_name,            String, :param => "displayName"
    attribute :institution_customer_id, String, :param => "institutionCustomerId"
    attribute :country_code,            String, :param => "countryCode"
    attribute :email,                   String
  end
end
