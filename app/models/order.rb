class Order
  attr_accessor :id
  attr_reader :meal, :customer, :delivered, :employee

  def initialize(attributes = {})
    @id = attributes[:id]
    @meal = attributes[:meal] # INSTANCES OF MEAL
    @customer = attributes[:customer] # INSTANCES OF customer
    @employee = attributes[:employee] # INSTANCES OF EMPLOYEE
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end