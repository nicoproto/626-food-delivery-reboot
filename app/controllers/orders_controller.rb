require_relative "../views/meals_view"
require_relative "../views/customers_view"
require_relative "../views/sessions_view"
require_relative "../views/orders_view"

class OrdersController
  def initialize(meal_repo, customer_repo, employee_repo, order_repo)
    @meal_repo = meal_repo
    @customer_repo = customer_repo
    @employee_repo = employee_repo
    @order_repo = order_repo
    @meals_view = MealsView.new
    @sessions_view = SessionsView.new
    @customers_view = CustomersView.new
    @orders_view = OrdersView.new
  end

  def add
    meal = select_meal
    customer = select_customer
    employee = select_employee
    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repo.create(order)
  end

  def list_undelivered_orders
    undelivered_orders = @order_repo.undelivered_orders
    @orders_view.display(undelivered_orders)
  end

  def list_my_orders(employee)
    my_orders = @order_repo.my_undelivered_orders(employee)
    @orders_view.display(my_orders)
  end

  def mark_as_delivered(current_user)
    list_my_orders(current_user)
    index = @orders_view.ask_user_for(:index).to_i - 1
    my_orders = @order_repo.my_undelivered_orders(current_user)
    order = my_orders[index]
    @order_repo.mark_as_delivered(order)
  end

  private

  def select_meal
    meals = @meal_repo.all
    # Show the list of meals
    @meals_view.display(meals)
    # Get the index
    index = @meals_view.ask_user_for(:index).to_i - 1
    return meals[index]
  end

  def select_customer
    customers = @customer_repo.all
    # Show the list of customers
    @customers_view.display(customers)
    # Get the index
    index = @customers_view.ask_user_for(:index).to_i - 1
    return customers[index]
  end

  def select_employee
    employees = @employee_repo.all
    # Show the list of employees
    @sessions_view.display(employees)
    # Get the index
    index = @sessions_view.ask_user_for(:index).to_i - 1
    return employees[index]
  end
end