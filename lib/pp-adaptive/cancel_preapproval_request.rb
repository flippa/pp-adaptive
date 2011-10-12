module AdaptivePayments
  class CancelPreapprovalRequest < AbstractRequest
    operation :CancelPreapproval

    attribute :preapproval_key, String, :param => "preapprovalKey"
  end
end
