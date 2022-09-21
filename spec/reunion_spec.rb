require "rspec"
require "./lib/reunion"

RSpec.describe Reunion do 
  before(:each) do 
    @activity_1 = Activity.new("Brunch")
    @reunion = Reunion.new("1406 BE")
  end

  describe "#initialize" do 
    it "exists" do 
      expect(@reunion).to be_an_instance_of(Reunion)
    end

    it "has a readable name" do 
      expect(@reunion.name).to eq("1406 BE")
    end

    it "starts out with no activities" do 
      expect(@reunion.activities).to eq([])
    end
  end

  describe "#add_activity" do 
    it "adds an activity to the reunion" do 
      @reunion.add_activity(@activity_1)
      expect(@reunion.activities).to eq([@activity_1])
    end
  end
end