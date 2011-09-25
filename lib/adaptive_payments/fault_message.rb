require "forwardable"

module AdaptivePayments
  module FaultMessage
    class << self
      def included(base)
        base.instance_eval do
          extend Forwardable

          attribute :errors, Object, :param => "error", :default => lambda { |obj, attr| List.new(ErrorData) }

          def_delegator :first_error, :id,        :error_id
          def_delegator :first_error, :domain,    :error_domain
          def_delegator :first_error, :subdomain, :error_subdomain
          def_delegator :first_error, :severity,  :error_severity
          def_delegator :first_error, :category,  :error_category
          def_delegator :first_error, :message,   :error_message
          def_delegator :first_error, :parameter, :error_parameter

#          attribute :error_id,        Integer, :param => "error(0).errorId"
#          attribute :error_domain,    String,  :param => "error(0).domain"
#          attribute :error_subdomain, String,  :param => "error(0).subdomain"
#          attribute :error_severity,  String,  :param => "error(0).severity"
#          attribute :error_category,  String,  :param => "error(0).category"
#          attribute :error_message,   String,  :param => "error(0).message"
#          attribute :error_parameter, String,  :param => "error(0).parameter"
        end
      end

      alias_method :extended, :included
    end

    def first_error
      errors.first || ErrorData.new
    end
  end
end
