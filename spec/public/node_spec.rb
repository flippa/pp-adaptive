require "spec_helper"

describe AdaptivePayments::Node do
  let(:child_model) do
    Class.new(AdaptivePayments::JsonModel) do
      attribute :example, String
    end
  end

  let(:model) do
    klass = child_model
    Class.new(AdaptivePayments::JsonModel) do
      attribute :child, AdaptivePayments::Node[klass]
    end
  end

  describe "default type" do
    let(:child) { model.new.child }

    it "is an instance of the boxed type" do
      child.should be_an_instance_of(child_model)
    end
  end

  describe "coercion" do
    let(:object) { model.new(:child => { :example => "anything" }) }

    it "coerces hash to instances of the given type" do
      object.child.should be_an_instance_of(child_model)
    end

    it "maintains the original keys" do
      object.child.example.should == "anything"
    end
  end

  describe "#to_json" do
    context "when not empty" do
      let(:json) { model.new(:child => { :example => "whatever" }).to_json }

      it "is present as a child in the output" do
        json.should == '{"child":{"example":"whatever"}}'
      end
    end

    context "when empty" do
      let(:json) { model.new.to_json }

      it "is omitted from the output" do
        json.should == '{}'
      end
    end
  end
end
