require "rspec"
require "./lib/activity"

RSpec.describe Activity do 
  before(:each) do
    @activity = Activity.new("Brunch")
  end

  describe "#initialize" do 
    it "exists" do 
      expect(@activity).to be_an_instance_of(Activity)
    end

    it "has a readable name" do 
      expect(@activity.name).to eq("Brunch")
    end

    it "starts out with no participants" do 
      expect(@activity.participants).to eq({})
    end
  end

  describe "#add_participant" do 
    it "adds a participant to the activity" do 
      @activity.add_participant("Maria", 20)
      expect(@activity.participants).to eq({"Maria"=>20})
      @activity.add_participant("Luther", 40)
      expect(@activity.participants).to eq({"Maria"=>20, "Luther"=>40})
    end
  end

  describe "#total_cost" do 
    it "calculates the total cost of the activity" do 
      @activity.add_participant("Maria", 20)
      expect(@activity.total_cost).to eq(20)
      @activity.add_participant("Luther", 40)
      expect(@activity.total_cost).to eq(60)
    end
  end

  describe "#split" do 
    before(:each) do 
      @activity.add_participant("Maria", 20)
      @activity.add_participant("Luther", 40)
    end

    it "splits the total_cost by the number of participants" do 
      expect(@activity.total_cost).to eq(60)
      expect(@activity.split).to eq(30)
    end
  end

  describe "#owed" do 
    before(:each) do 
      @activity.add_participant("Maria", 20)
      @activity.add_participant("Luther", 40)
    end

    it "returns a hash with participant names => amount owed" do 
      expect(@activity.owed).to eq({"Maria"=>10, "Luther"=>-10})
    end
  end
end