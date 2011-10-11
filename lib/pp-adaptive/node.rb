require "virtus"

module AdaptivePayments
  class Node < Virtus::Attribute::Object
    attr_reader :type

    class << self
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
