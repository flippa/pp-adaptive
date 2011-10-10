require "spec_helper"

describe AdaptivePayments::NodeList do
  let(:child_model) do
    Class.new(AdaptivePayments::JsonModel) do
      attribute :example, String
    end
  end

  let(:model) do
    klass = child_model
    Class.new(AdaptivePayments::JsonModel) do
      attribute :children, AdaptivePayments::NodeList[klass]
    end
  end

  describe "default type" do
    it "is a kind of Array" do
      model.new.children.should be_a_kind_of(Array)
    end
  end

  describe "coercion" do
    context "when appending to" do
      let(:object) { model.new.tap { |o| o.children << { :example => "anything" } } }

      it "coerces hash to instances of the given type" do
        object.children.first.should be_an_instance_of(child_model)
      end
    end

    context "when overwriting" do
      let(:object) { model.new.tap { |o| o.children = [{ :example => "anything" }] } }

      it "coerces each member to instances of the given type" do
        object.children.first.should be_an_instance_of(child_model)
      end
    end
  end

  describe "#to_json" do
    context "when not empty" do
      let(:json) { model.new.tap { |o| o.children = [{ :example => "whatever" }] }.to_json }

      it "is present as a child in the output" do
        json.should == '{"children":[{"example":"whatever"}]}'
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
