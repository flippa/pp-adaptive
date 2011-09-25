module AdaptivePayments
  class List < ::Array
    def initialize(klass)
      @klass = klass
    end

    def insert_from_hash(hash)
      push(@klass.new.tap { |m| m.load_hash(hash) })
    end

    def <<(object)
      object = @klass.new(object) unless object.kind_of?(@klass)
      super
    end
  end
end
