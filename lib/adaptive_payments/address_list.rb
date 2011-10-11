module AdaptivePayments
  class AddressList < JsonModel
    attribute :addresses, NodeList[Address], :param => "address"
  end
end
