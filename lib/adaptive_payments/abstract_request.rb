module AdaptivePayments
  class AbstractRequest
    include Virtus

    class << self
      def operation(name = nil)
        @operation = name unless name.nil?
        @operation
      end
    end

    def to_hash
      attributes.inject({}) do |hash, (attr, value)|
        hash.merge(param_key(attr) => value.to_s)
      end
    end

    private

    def param_key(attr)
      self.class.attributes[attr].options.fetch(:param, attr)
    end
  end
end
