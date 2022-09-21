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

  def details
    lenders = owed.select { |name, amount| amount < 0 }.keys
    debtors = owed.select { |name, amount| amount > 0 }.keys
    owed.each_with_object(Hash.new{|h,k| h[k] = {activity: @name, payees: [], amount: 0}}) do |(person, amount), hash|
      amount > 0 ? hash[person][:payees].concat(lenders) : hash[person][:payees].concat(debtors)
      amount > 0 ? hash[person][:amount] = amount / lenders.length : hash[person][:amount] = amount / debtors.length
    end
  end
end