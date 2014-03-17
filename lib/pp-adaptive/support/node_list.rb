require "virtus"

module AdaptivePayments
  # A Virtus Attribute used to hold a collection of objects boxed to a given type.
  #
  # The NodeList Attribute should not be used directly. Instead, it should be given a type to box.
  #
  #   attribute :children, NodeList[Child], :param => "child"
  #
  # In the above, the model gets an Array accessible through model.children.  All objects contained
  # in the Array will be coerced to the boxed type. If an Array is assigned directly to the attribute,
  # all items inside it will be coerced to the boxed type.  If a Hash is pushed onto the existing
  # Array, it will be coerced to the boxed type.
  class NodeList < Virtus::Attribute

    # Allow access to the boxed type
    attr_reader :type

    class << self
      # Return a descendant of NodeList boxing the given type.
      #
      # @param [Class<JsonModel>] type
      #   the type to box
      #
      # @return [NodeList]
      #   an anonymous descendant of NodeList boxing the given type
      def [](type)
        raise ArgumentError, "Lists may only be created from JsonModel classes" unless type <= JsonModel

        Class.new(self) do
          default lambda { |m, a| arr = CoercedArray.for_type(type) }

          define_method :type do
            type
          end

          define_method :coerce do |value|
            CoercedArray.for_type(type) + Array.new(value)
          end
        end
      end
    end
  end
end
