require 'spec_helper'

describe Enumitation do
  before(:all) do
    class MyModel < ActiveRecord::Base
      enumitation :number, %w[1 2]
    end
  end

  after(:all) do
    Object.send :remove_const, :MyModel
  end

  it "adds the enumitation method to the model" do
    MyModel.methods.should include(:enumitation)
  end

  describe "#enumitation" do
    it "adds the select_options_for method to the model" do
      MyModel.methods.should include(:select_options_for)
    end

    it "adds the validates_inclusion_of validator to the model" do
      MyModel.should have(1).validators_on :number

      validator = MyModel.validators.first
      validator.should be_a_kind_of ActiveModel::Validations::InclusionValidator

      validator.options[:in].should == %w[1 2]
    end

    it "can be called more than once without reinitializing the enumitation values" do
      # Validate that the original enumitation still exists
      MyModel.enumitation_values.keys.should include(:number)

      MyModel.enumitation :other_field, %w[one two]

      # Should still include the :number enumitation
      MyModel.enumitation_values.keys.should include(:number)
    end
  end
end
