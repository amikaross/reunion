class Reunion 
  attr_reader :name,
              :activities

  def initialize(name)
    @name = name 
    @activities = []
  end

  def add_activity(activity)
    @activities << activity
  end

  def total_cost
    @activities.sum { |activity| activity.total_cost }
  end

  def breakout
    @activities.each_with_object(Hash.new(0)) do |activity, hash|
      activity.owed.each { |name, owed| hash[name] += owed }
    end
  end

  def summary 
    breakout.each_with_object("") do |(name, amount), str|
      str << "#{name}: #{amount}"
      str << "\n" if name != breakout.keys.last
    end
  end

  def detailed_breakout
    new_hash = breakout.transform_values { |value| [] }
    new_hash.each do |name, array| 
      @activities.each do |activity|
        array << activity.details[name] if activity.participants.keys.include?(name)
      end 
    end
  end
end