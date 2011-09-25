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
  end
end
