require "spec_helper"
require "virtus"

describe AdaptivePayments::JsonModel do
  let(:model) do
    Class.new(AdaptivePayments::JsonModel) do
      attribute :an_example, String, :param => "anExample"
      attribute :simple,     String
      attribute :numeric,    BigDecimal
      attribute :optional,   String, :default => "test"
    end
  end

  describe "coercion" do
    let(:object) { model.new(:an_example => "string", :numeric => 20) }

    it "casts inputs to the correct type" do
      expect(object.an_example).to eq("string")
      expect(object.numeric).to eq(BigDecimal("20.00"))
    end
  end

  describe "default values" do
    let(:object) { model.new }

    it "reads the :default option for a default value" do
      expect(object.optional).to eq("test")
    end
  end

  describe "#to_json" do
    context "with empty values" do
      let(:json) { model.new.to_json }

      it "omits the empty values" do
        expect(json).to eq('{"optional":"test"}')
      end
    end

    context "with decimal values" do
      let(:json) { model.new(:numeric => 10).to_json }

      it "formats the decimal to scale 2" do
        expect(json).to eq('{"numeric":"10.00","optional":"test"}')
      end
    end

    context "with a :param option" do
      let(:json) { model.new(:an_example => "whatever").to_json }

      it "uses the param as the key" do
        expect(json).to eq('{"anExample":"whatever","optional":"test"}')
      end
    end
  end
end
