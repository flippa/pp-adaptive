require "forwardable"

module AdaptivePayments
  module FaultMessage
    class << self
      def included(base)
        base.instance_eval do
          extend Forwardable

          attribute :errors, Object, :param => "error", :default => lambda { |obj, attr| List.new(ErrorData) }

          def_delegator :first_error, :id,         :error_id
          def_delegator :first_error, :domain,     :error_domain
          def_delegator :first_error, :subdomain,  :error_subdomain
          def_delegator :first_error, :severity,   :error_severity
          def_delegator :first_error, :category,   :error_category
          def_delegator :first_error, :message,    :error_message
          def_delegator :first_error, :parameters, :error_parameters
        end
      end
    end

    def first_error
      errors.first || ErrorData.new
    end
  end
end
