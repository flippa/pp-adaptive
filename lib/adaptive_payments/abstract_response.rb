module AdaptivePayments
  class AbstractResponse
    include Virtus

    class << self
      def operation(name = nil)
        @operation = name unless name.nil?
        @operation
      end
    end

    def initialize(response_string)
      super(parse(response_string.to_s))
    end

    private

    def parse(string)
      require 'uri'

      map = self.class.attributes.inject({}) do |hash, attr|
        hash.merge(attr.options.fetch(:param, attr.name).to_s => attr.name)
      end

      string.split("&").inject({}) do |hash, pair|
        key, value = pair.split("=").map { |v| URI.decode(v) }
        next hash if map[key].nil?
        hash.merge(map[key] => value)
      end
    end
  end
end
