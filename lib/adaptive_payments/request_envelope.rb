module AdaptivePayments
  module RequestEnvelope
    def self.included(base)
      base.instance_eval do
        attribute :detail_level,    String, :param => "requestEnvelope.detailLevel"
        attribute :error_language,  String, :param => "requestEnvelope.errorLanguage", :default => "en_US"
      end

      alias_method :extended, :included
    end
  end
end
