require "virtus"

module AdaptivePayments
  class RequestModel
    include Virtus

    def to_hash
      attributes.inject({}) do |result, (attr, value)|
        next result if value.nil?
        merge_hash_with_value_for_key(result, attr, value)
      end
    end

    private

    def param_key(attr)
      if self.class.attributes[attr]
        self.class.attributes[attr].options.fetch(:param, attr).to_s
      else
        attr.to_s
      end
    end

    def merge_hash_with_value_for_key(hash, key, value)
      case value
        when ::Array
          merge_hash_with_array_for_key(hash, key, value)
        when ::Virtus
          merge_hash_with_child_for_key(hash, key, value)
        else
          merge_hash_with_string_for_key(hash, key, value)
      end
    end

    def merge_hash_with_array_for_key(hash, key, value)
      param = param_key(key)
      value.each_with_index do |v, i|
        hash = merge_hash_with_value_for_key(hash, "%s(%d)" % [param, i], v)
      end
      hash
    end

    def merge_hash_with_child_for_key(hash, key, value)
      param = param_key(key)
      value.to_hash.each do |k, v|
        hash = merge_hash_with_value_for_key(hash, "%s.%s" % [param, k], v)
      end
      hash
    end

    def merge_hash_with_string_for_key(hash, key, value)
      str_val = case value
        when ::BigDecimal
          "%.2f" % value
        else
          value.to_s
      end
      hash.merge(param_key(key) => str_val)
    end
  end
end
