require "forwardable"
require "virtus"

module AdaptivePayments
  # Provides an interface to create shortcuts to child nodes without traversing an object graph
  module Aliases
    include Forwardable

    # Invoke alias_name as if original_name were invoked on attr
    #
    # @param [Symbol]
    #   the name of the attribute containing the child node
    # @param [Symbol]
    #   the name of the alias method to define
    # @param [Symbol] the name of the original method in attr
    def alias_param(attr, alias_name, original_name)
      def_delegator attr, original_name,        alias_name
      def_delegator attr, :"#{original_name}=", :"#{alias_name}="
      def_delegator attr, :"#{original_name}?", :"#{alias_name}?" if attributes[attr].kind_of?(Virtus::Attribute::Boolean)
    end

    # Shortcut for definining multiple aliases in a single call
    #
    # @param [Symbol]
    #   the name of the attribute containing the child node
    # @param [Hash]
    #   a Hash mapping { :alias_name => :original_name }
    def alias_params(attr, aliases)
      aliases.each { |k, v| alias_param(attr, k, v) }
    end
  end
end
