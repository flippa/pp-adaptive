module AdaptivePayments
  class SenderIdentifier < AccountIdentifier
    attribute :use_credentials, Boolean, :param => "useCredentials"
  end
end
