require "virtus"

module AdaptivePayments
  class Model
    include Virtus

    def self.from_string(string)
      require 'uri'
      hash = string.split("&").inject({}) do |result, pair|
        key, value = pair.split("=").map { |v| URI.decode(v.gsub("+", "%20")) }
        result.merge(key => value)
      end
      new.tap { |m| m.load_hash(hash) }
    end

    module Writing
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
          when Model
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

    module Parsing
      def load_hash(hash)
        map = self.class.attributes.inject({}) do |result, attr|
          result.merge(attr.options.fetch(:param, attr.name).to_s => attr.name)
        end

        # exact matches first
        self.attributes = map.inject({}) do |result, (key, value)|
          next result if hash[key].nil?
          map.delete(key)
          result.merge(value => hash[key])
        end

        # arrays next
        attributes.select{ |k, v| v.kind_of?(Array) }.each do |key, value|
          next unless param = map.invert[key]
          if value.kind_of?(List)
            extract_array_of_hashes_with_key(param, hash).each do |sub_hash|
              value.insert_from_hash(sub_hash)
            end
          else
            extract_array_of_values_with_key(param, hash).each do |v|
              value << v
            end
          end
        end

        # now all the children
        attributes.select{ |k, v| v.kind_of?(Model) }.each do |key, value|
          next unless param = map.invert[key]
          value.load_hash(extract_hash_with_key(param, hash))
        end
      end

      private

      def extract_hash_with_key(key, hash)
        pattern = /^#{Regexp.escape(key)}\.(.+)$/
        hash.inject({}) do |result, (k, v)|
          next result unless match = pattern.match(k)
          result.merge(match[1] => v)
        end
      end

      def extract_array_of_values_with_key(key, hash)
        pattern = /^(#{Regexp.escape(key)}\(\d+\))$/
        hash.select{ |k, v| pattern.match(k) }.values
      end

      def extract_array_of_hashes_with_key(key, hash)
        pattern = /^(#{Regexp.escape(key)}\(\d+\))\.(.+)$/
        hash.inject({}) do |hashes, (k, v)|
          next hashes unless match = pattern.match(k)
          hashes[match[1]] ||= {}
          hashes.merge(match[1] =>  { match[2] => v }) { |m, a, b| a.merge(b) }
        end.values
      end
    end

    include Writing
    include Parsing
  end
end
