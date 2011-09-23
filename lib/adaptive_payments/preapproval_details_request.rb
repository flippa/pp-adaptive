module AdaptivePayments
  class PreapprovalDetailsRequest < AbstractRequest
    operation :PreapprovalDetails

    attribute :preapproval_key,     String,  :param => "preapprovalKey"
    attribute :get_billing_address, Boolean, :param => "getBillingAddress"
  end
end
