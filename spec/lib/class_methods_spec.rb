require 'spec_helper'

describe Enumitation::ClassMethods do
  before(:all) do
    class MyModel < ActiveRecord::Base
      enumitation :number, %w[1 2]
    end
  end

  after(:all) do
    Object.send :remove_const, :MyModel
  end

  describe "select_options_for" do
    context "when no label translation is present" do
      it "returns select options with label and value of equal values" do
        MyModel.select_options_for(:number).should == [%w[1 1], %w[2 2]]
      end
    end

    context "when label translation is present" do
      before do
        %w[1 2].each do |num|
          mock(I18n).t(num,
                       :scope => "enumitation.models.my_model.number",
                       :default => num) do

            if num == '1'
              'one'
            elsif num == '2'
              'two'
            end
          end
        end
      end

      it "returns select options with the label translated" do
        MyModel.select_options_for(:number).should == [%w[one 1], %w[two 2]]
      end
    end
  end
end
