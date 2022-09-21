class Activity 
  attr_reader :name,
              :participants

  def initialize(name)
    @name = name 
    @participants = {}
  end

  def add_participant(name, amount)
    @participants[name] = amount
  end

  def total_cost
    @participants.values.sum
  end

  def split 
    total_cost / @participants.count
  end

  def owed 
    @participants.transform_values { |amount| split - amount } 
  end
end