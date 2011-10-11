module AdaptivePayments
  # Array that coerces all input values to a JsonModel of the given type
  class CoercedArray < Array
    # Initialize the CoercedArray for the given type
    #
    # @param [Class<JsonModel>] type
    #   the JsonModel descendant to coerce to
    def initialize(type)
      raise ArgumentError, "The type in a CoercedArray must be a JsonModel" unless type <= JsonModel

      super()
      @type = type
    end

    # Append the given value to the Array
    # The value may be a Hash to coerce, or a valid JsonModel
    #
    # @param [Hash, JsonModel] object
    #   the object to append
    #
    # @return CoercedArray
    def push(object)
      object = @type.new(object) unless object.kind_of?(@type)
      super
    end

    alias_method :<<, :push

    # Concatenate another Array with this one and return the result as a new Array
    # All items in other will be coerced to the correct type
    #
    # @param [Array] other
    #   another Array to concatenate with
    #
    # @return CoercedArray
    def +(other)
      raise ArgumentError, "Cannot union #{other.class} with #{self.class}<#{@type}>" unless other.kind_of?(Array)
      super(CoercedArray.new(@type).concat(other))
    end

    # Concatenate another Array with this one and modify the Array in place
    #
    # @param [Array] other
    #   another Array to concatenate with
    #
    # @return CoercedArray
    def concat(other)
      raise ArgumentError, "Cannot append #{other.class} to #{self.class}<#{@type}>" unless other.kind_of?(Array)
      super(other.inject(CoercedArray.new(@type)) { |ary, v| ary.push(v) })
    end
  end
end
