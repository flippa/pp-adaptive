module AdaptivePayments
  class ReceiverList < JsonModel
    attribute :receivers, NodeList[Receiver], :param => "receiver"
  end
end
