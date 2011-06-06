require 'spec_helper'

describe Enumitation do
  class MyModel < ActiveRecord::Base
    enumitation :number, %w[1 2]
  end

  it "adds the enumitation method to the model" do
    MyModel.methods.should include(:enumitation)
  end

  it "adds the select_options_for method to the model" do
    MyModel.methods.should include(:select_options_for)
  end

  it "adds the validates_inclusion_of validator to the model" do
    MyModel.should have(1).validators_on :number

    validator = MyModel.validators.first
    validator.should be_a_kind_of ActiveModel::Validations::InclusionValidator

    validator.options[:in].should == %w[1 2]
  end

  describe "select_options_for" do
    context "when no label translation is present" do
      it "returns select options with label and value of equal values" do
        MyModel.select_options_for(:number).should == [%w[1 1], %w[2 2]]
      end
    end

    context "when label translation is present" do
      before do
        stub(I18n).t.with_any_args do |*args|
          val = args.first
          if val == '1'
            'one'
          elsif val == '2'
            'two'
          end
        end
      end

      it "returns select options with the label translated" do
        MyModel.select_options_for(:number).should == [%w[one 1], %w[two 2]]
      end
    end
  end
end
