module AdaptivePayments
  module FaultMessage
    def self.included(base)
      base.instance_eval do
        attribute :errors, NodeList[ErrorData], :param => "error"

        alias_params :first_error, {
          :error_id         => :id,
          :error_domain     => :domain,
          :error_subdomain  => :subdomain,
          :error_severity   => :severity,
          :error_category   => :category,
          :error_message    => :message,
          :error_parameters => :parameters
        }
      end
    end

    def first_error
      errors.first || ErrorData.new
    end
  end
end
