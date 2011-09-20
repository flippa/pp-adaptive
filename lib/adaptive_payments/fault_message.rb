module AdaptivePayments
  module FaultMessage
    class << self
      def included(base)
        base.instance_eval do
          attribute :error_id,        Integer, :param => "error(0).errorId"
          attribute :error_domain,    String,  :param => "error(0).domain"
          attribute :error_subdomain, String,  :param => "error(0).subdomain"
          attribute :error_severity,  String,  :param => "error(0).severity"
          attribute :error_category,  String,  :param => "error(0).category"
          attribute :error_message,   String,  :param => "error(0).message"
          attribute :error_parameter, String,  :param => "error(0).parameter"
        end
      end

      alias_method :extended, :included
    end
  end
end
