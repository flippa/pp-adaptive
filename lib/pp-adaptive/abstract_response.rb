module AdaptivePayments
  # AbstractResponse provides a JsonModel with the default behaviour for all responses
  #
  # The ResponseEnvelope is already included by default.  It does not need to be redeclared in descendants.
  #
  # All responses have FaultMessage behaviour mixed in, so will behave as a FaultMessage if the API returns one.
  class AbstractResponse < JsonModel
    include FaultMessage

    # The ResponseEnvelope, encapsulating common information about the response
    #
    # All attributes #ack_code, #build, #correlation_id and #time are aliased as top-level attributes,
    # so you do not need to access #response_envelope directly.
    #
    # @see #success?, #failure?, #warning?, #success_with_warning?, #failure_with_warning?
    attribute :response_envelope, Node[ResponseEnvelope], :param => "responseEnvelope"

    alias_params :response_envelope, {
      :ack_code       => :ack_code,
      :build          => :build,
      :correlation_id => :correlation_id,
      :time           => :time
    }

    class << self
      # Set or get the API operation
      #
      # This method should be called in descendants, but is not currently used.
      #
      # @param [Symbol] name
      #   the name of the API operation as defined by PayPal, optional
      #
      # @return [Symbol]
      #   the name of the API operation as defined by PayPal
      def operation(name = nil)
        @operation = name unless name.nil?
        @operation
      end
    end

    # Provide status predicates for the possible response ack codes
    %w{success? failure? warning? success_with_warning? failure_with_warning?}.each do |method|
      define_method(method) { response_envelope.send(method) }
    end
  end
end
