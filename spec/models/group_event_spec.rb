require 'rails_helper'

RSpec.describe GroupEvent, type: :model do

  describe "#mark_as_removed!" do
    it "set to true and update the :removed attribute" do
      ge = create(:group_event)
      ge.mark_as_removed!

      expect(ge.removed).to be_truthy
    end
  end

  describe "#format_attributes" do
    context "with :start_on and :duration present" do
      it "calculate and set the :end_on attribute" do
        ge = build(:group_event, start_on: Date.today, 
                    duration: 60, end_on: nil)
        ge.save

        expect(ge.end_on).to eq(Date.today + 60)
      end
    end

    context "with :start_on and :end_on present" do
      it "calculate and set the :duration attribute" do
        ge = build(:group_event, start_on: Date.today, 
                    end_on: Date.today + 60, duration: nil)
        ge.save

        expect(ge.duration).to eq(60)
      end
    end

    context "with :duration and :end_on present" do
      it "calculate and set the :start_on attribute" do
        ge = build(:group_event, duration: 60, 
                    end_on: Date.today + 60, start_on: nil)
        ge.save

        expect(ge.start_on).to eq(Date.today)
      end
    end
  end

  describe "#any_base_attribute_present" do
    it "validates the present of at least one base attributes" do
      ge = GroupEvent.new
      ge.valid?

      expect(ge.errors[:base]).to include("specify at least one base attribute")
    end
  end

  describe "#all_base_attributes_present?" do
    context "with all the base attributes present" do
      it "returns true" do
        ge = create(:group_event)
        
        expect(ge.send('all_base_attributes_present?')).to be_truthy
      end
    end
    
    context "with any of the base attributes missing" do
      it "returns false" do
        ge = create(:group_event, name: nil)
        
      expect(ge.send('all_base_attributes_present?')).to be_falsey
      end
    end
  end
end
