require "forwardable"

module AdaptivePayments
  class PayError < Model
    extend Forwardable

    attribute :receiver,    Object, :default => lambda { |obj, attr| Receiver.new }
    attribute :error,       Object, :default => lambda { |obj, attr| ErrorData.new }

    def_delegator :receiver, :email,   :receiver_email
    def_delegator :receiver, :amount,  :receiver_amount
    def_delegator :receiver, :payment_type
    def_delegator :receiver, :payment_subtype
    def_delegator :receiver, :invoice_id

    def_delegator :error, :id,        :error_id
    def_delegator :error, :domain,    :error_domain
    def_delegator :error, :subdomain, :error_subdomain
    def_delegator :error, :severity,  :error_severity
    def_delegator :error, :category,  :error_category
    def_delegator :error, :message,   :error_message
    def_delegator :error, :parameter, :error_parameter
  end
end
