module AdaptivePayments
  class DisplayOptions < JsonModel
    attribute :email_header_image_url,    String, :param => "emailHeaderImageUrl"
    attribute :email_marketing_image_url, String, :param => "emailMarketingImageUrl"
    attribute :header_image_url,          String, :param => "headerImageUrl"
    attribute :business_name,             String, :param => "businessName"
  end
end
