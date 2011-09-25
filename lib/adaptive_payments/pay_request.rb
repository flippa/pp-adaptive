require "forwardable"

module AdaptivePayments
  class PayRequest < AbstractRequest
    extend  Forwardable
    include ClientDetails

    operation :Pay

    attribute :receivers,                          Object,  :param => "receiverList.receiver", :default => lambda { |obj, attr| List.new(Receiver) }
    attribute :action_type,                        String,  :param => "actionType"
    attribute :currency_code,                      String,  :param => "currencyCode"
    attribute :cancel_url,                         String,  :param => "cancelUrl"
    attribute :return_url,                         String,  :param => "returnUrl"
    attribute :ipn_notification_url,               String,  :param => "ipnNotificationUrl"
    attribute :sender_email,                       String,  :param => "sender.email"
    attribute :preapproval_key,                    String,  :param => "preapprovalKey"
    attribute :pin,                                String
    attribute :reverse_parallel_payments_on_error, Boolean, :param => "reverseAllParallelPaymentsOnError"
    attribute :tracking_id,                        String,  :param => "trackingId"
    attribute :memo,                               String

    def_delegator :first_receiver, :email=,  :receiver_email=
    def_delegator :first_receiver, :email,   :receiver_email
    def_delegator :first_receiver, :amount=, :receiver_amount=
    def_delegator :first_receiver, :amount,  :receiver_amount

    def_delegator :first_receiver, :payment_type=
    def_delegator :first_receiver, :payment_type
    def_delegator :first_receiver, :payment_subtype=
    def_delegator :first_receiver, :payment_subtype
    def_delegator :first_receiver, :invoice_id=
    def_delegator :first_receiver, :invoice_id

    # FIXME: I think this can go away?
    def initialize(attributes = {})
      super
      first_receiver # initialize the primary receiver
    end

    def receivers=(list_of_receivers) # FIXME: This is why we need a proper Attribute for this
      list_of_receivers.each { |r| receivers << r }
    end

    private

    def first_receiver
      receivers[0] ||= Receiver.new
    end

    # FIXME: Add sender.phone
    # FIXME: Add funding options stuff

    # For explicit approval, redirect the user to https://www.paypal.com/webscr?cmd=_ap-payment&paykey=value
    # When paying for DIGITALGOODS, use https://paypal.com/webapps/adaptivepayment/flow/pay?paykey=
  end
end
