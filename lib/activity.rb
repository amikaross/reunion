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
end