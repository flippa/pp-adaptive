module AdaptivePayments
  class PreapprovalResponse < AbstractResponse
    operation :Preapproval

    attribute :preapproval_key, String,   :param => "preapprovalKey"
  end
end
