module AdaptivePayments
  class AccountIdentifier < JsonModel
    attribute :email, String
    attribute :phone, Node[PhoneNumberType]
  end
end
