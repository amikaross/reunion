require "rspec"
require "./lib/reunion"

RSpec.describe Reunion do 
  before(:each) do 
    @activity_1 = Activity.new("Brunch")
    @activity_1.add_participant("Maria", 20)
    @activity_1.add_participant("Luther", 40)
    @activity_2 = Activity.new("Drinks")
    @activity_2.add_participant("Maria", 60)
    @activity_2.add_participant("Luther", 60)
    @activity_2.add_participant("Louis", 0)
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

  describe "#total_cost" do 
    it "returns the total cost of all activities" do 
      @reunion.add_activity(@activity_1)
      expect(@reunion.total_cost).to eq(60)
      @reunion.add_activity(@activity_2)
      expect(@reunion.total_cost).to eq(180)
    end
  end

  describe "#breakout" do 
    it "returns a hash with person name => owed amount for whole reunion" do 
      @reunion.add_activity(@activity_1)
      @reunion.add_activity(@activity_2)
      expect(@reunion.breakout).to eq({"Maria"=>-10, "Luther"=>-30, "Louis"=>40})
    end
  end

  describe "#summary" do 
    it "returns a string showing name: owed amount for each person" do 
      @reunion.add_activity(@activity_1)
      @reunion.add_activity(@activity_2)
      expect(@reunion.summary).to eq("Maria: -10\nLuther: -30\nLouis: 40")
    end
  end

  describe "#detailed_breakout" do 
    before(:each) do 
      @activity_3 = Activity.new("Bowling")
      @activity_3.add_participant("Maria", 0)
      @activity_3.add_participant("Luther", 0)
      @activity_3.add_participant("Louis", 30)
      @activity_4 = Activity.new("Jet Skiing")
      @activity_4.add_participant("Maria", 0)
      @activity_4.add_participant("Luther", 0)
      @activity_4.add_participant("Louis", 40)
      @activity_4.add_participant("Nemo", 40)
      @reunion.add_activity(@activity_1)
      @reunion.add_activity(@activity_2)
      @reunion.add_activity(@activity_3)
      @reunion.add_activity(@activity_4)
    end

    it "returns a hash with name => {activity: <string>, payees: <array of participants>, amount: <int>" do 
      expected_result = 
          {
           "Maria" => [
             {
               activity: "Brunch",
               payees: ["Luther"],
               amount: 10
             },
             {
               activity: "Drinks",
               payees: ["Louis"],
               amount: -20
             },
             {
               activity: "Bowling",
               payees: ["Louis"],
               amount: 10
             },
             {
               activity: "Jet Skiing",
               payees: ["Louis", "Nemo"],
               amount: 10
             }
           ],
           "Luther" => [
             {
               activity: "Brunch",
               payees: ["Maria"],
               amount: -10
             },
             {
               activity: "Drinks",
               payees: ["Louis"],
               amount: -20
             },
             {
               activity: "Bowling",
               payees: ["Louis"],
               amount: 10
             },
             {
               activity: "Jet Skiing",
               payees: ["Louis", "Nemo"],
               amount: 10
             }
           ],
           "Louis" => [
             {
               activity: "Drinks",
               payees: ["Maria", "Luther"],
               amount: 20
             },
             {
               activity: "Bowling",
               payees: ["Maria", "Luther"],
               amount: -10
             },
             {
               activity: "Jet Skiing",
               payees: ["Maria", "Luther"],
               amount: -10
             }
           ],
           "Nemo" => [
             {
               activity: "Jet Skiing",
               payees: ["Maria", "Luther"],
               amount: -10
             }
           ]
         }
      expect(@reunion.detailed_breakout).to eq(expected_result)
    end
  end
end