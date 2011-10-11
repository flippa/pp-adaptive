module AdaptivePayments
  class Address < JsonModel
    attribute :id,             String,            :param => "addressId"
    attribute :addressee_name, String,            :param => "addresseeName"
    attribute :base_address,   Node[BaseAddress], :param => "baseAddress"

    alias_params :base_address, {
      :line1        => :line1,
      :line2        => :line2,
      :city         => :city,
      :state        => :state,
      :postal_code  => :postal_code,
      :country_code => :country_code,
      :type         => :type
    }
  end
end
