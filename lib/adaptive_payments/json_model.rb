require "virtus"
require "json"

module AdaptivePayments
  class JsonModel
    include Virtus

    def to_hash
      attributes.inject({}) { |hash, (key, value)| value ? hash.merge(json_key(key) => json_value(value)) : hash } \
        .reject { |key, value| value.respond_to?(:empty?) && value.empty? }
    end

    def to_json(*)
      to_hash.to_json
    end

    def json_key(key)
      if self.class.attributes[key]
        self.class.attributes[key].options.fetch(:param, key).to_s
      else
        key.to_s
      end
    end

    def json_value(value)
      case value
        when JsonModel
          value.to_hash
        when CoercedArray
          value.collect { |v| v.to_hash }
        else
          value
      end
    end
  end
end
