module AdaptivePayments
  class InitiatingEntity < JsonModel
    attribute :institution_customer, Node[InstitutionCustomer], :param => "institutionCustomer"

    alias_params :institution_customer, {
      :institution_id         => :institution_id,
      :customer_first_name    => :first_name,
      :customer_last_name     => :last_name,
      :customer_display_name  => :display_name,
      :insitution_customer_id => :institution_customer_id,
      :customer_country_code  => :country_code,
      :customer_email         => :email
    }
  end
end
