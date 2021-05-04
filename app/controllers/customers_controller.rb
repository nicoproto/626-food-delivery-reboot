require_relative "../views/customers_view"
require_relative "../models/customer"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customer_view = CustomersView.new
  end

  def list
    display_all
  end

  def add
    # 1. Ask user for name (view)
    name = @customer_view.ask_user_for(:name)
    # 2. Ask user for address (view)
    address = @customer_view.ask_user_for(:address)
    # 3. Create new Customer instance
    customer = Customer.new(name: name, address: address)
    # 4. Store it in the repository (repo)
    @customer_repository.create(customer)
    display_all
  end

  def display_all
    customers = @customer_repository.all
    @customer_view.display(customers)
  end
end
