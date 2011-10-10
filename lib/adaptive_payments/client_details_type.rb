module AdaptivePayments
  class ClientDetailsType < JsonModel
    attribute :ip_address,     String, :param => "ipAddress"
    attribute :device_id,      String, :param => "deviceId"
    attribute :application_id, String, :param => "applicationId"
    attribute :model,          String
    attribute :geo_location,   String, :param => "geoLocation"
    attribute :customer_type,  String, :param => "customerType"
    attribute :partner_name,   String, :param => "partnerName"
    attribute :customer_id,    String, :param => "customerId"
  end
end
