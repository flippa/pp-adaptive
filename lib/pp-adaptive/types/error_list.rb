module AdaptivePayments
  class ErrorList < JsonModel
    attribute :errors, NodeList[ErrorData], :param => "error"
  end
end
