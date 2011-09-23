module AdaptivePayments
  module RequestEnvelope
    class << self
      def included(base)
        base.instance_eval do
          attribute :detail_level,    String, :param => "requestEnvelope.detailLevel"
          attribute :error_language,  String, :param => "requestEnvelope.errorLanguage", :default => "en_US"
        end
      end

      alias_method :extended, :included
    end
  end
end
