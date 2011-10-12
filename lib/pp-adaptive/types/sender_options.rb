module AdaptivePayments
  class SenderOptions < JsonModel
    attribute :require_shipping_address_selection, Boolean, :param => "requireShippingAddressSelection"
  end
end
