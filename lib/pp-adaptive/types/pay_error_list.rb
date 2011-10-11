module AdaptivePayments
  class PayErrorList < JsonModel
    attribute :pay_errors, NodeList[PayError], :param => "payError"
  end
end
