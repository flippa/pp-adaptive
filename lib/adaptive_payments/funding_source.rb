module AdaptivePayments
  class FundingSource < Model
    attribute :id,                          String,  :param => "fundingSourceId"
    attribute :last_four_digits_of_account, String,  :param => "lastFourOfAccountNumber"
    attribute :type,                        String
    attribute :display_name,                String,  :param => "displayName"
    attribute :allowed,                     Boolean
  end
end
