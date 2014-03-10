require "virtus"

module AdaptivePayments
  # A Virtus Attribute used to box a type from the API to an Attribute in a JsonModel
  #
  # The Node type should not be used directly.  Instead it should be given a type to box.
  #
  #   attribute :child, Node[Child], :param => "childItem"
  #
  # In the above, the model gets an Attribute named #child, mapping to a JSON parameter named 'childItem'.
  # The object at `model.child` is present by default, and is an object of type Child.
  #
  # Assigning a Hash directly to the attribute will store an object of the boxed type, based on the elements
  # in the Hash.
  class Node < Virtus::Attribute
    # Provide access to the boxed type
    attr_reader :type

    class << self
      # Returns a descendant of Node, boxing the given type
      #
      # @param [Class<JsonModel>] type
      #   the class definition to box
      #
      # @return [Node<type>]
      #   an anonymous descendant of Node boxing the given type
      def [](type)
        raise ArgumentError, "Child nodes may only be other JsonModel classes" unless type <= JsonModel

        @generated_class_map       ||= {}
        @generated_class_map[type] ||= Class.new(self) do
          default lambda { |m, a| type.new }

          define_method :type do
            type
          end

          define_method :coerce do |value|
            value.kind_of?(Hash) ? type.new(value) : value
          end
        end
      end
    end
  end
end
