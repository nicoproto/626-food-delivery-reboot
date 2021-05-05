class Employee
  attr_reader :username, :id, :password

  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role] # manager / rider
  end

  def manager?
    @role == "manager"
  end
end