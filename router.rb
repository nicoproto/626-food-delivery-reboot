class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      @employee = @sessions_controller.sign_in
      while @employee
        if @employee.manager?
          display_manager_menu
          choice = gets.chomp.to_i
          print `clear`
          route__manager_action(choice)
        else
          display_rider_menu
          choice = gets.chomp.to_i
          print `clear`
          route__rider_action(choice)
        end
      end
    end
  end

  def display_manager_menu
    puts "---------------"
    puts "-----MENU------"
    puts "---------------"
    puts "1. Add a new meal"
    puts "2. List all meals"
    puts "3. Add a new customer"
    puts "4. List all customers"
    puts "5. Add new order"
    puts "6. List all undelivered orders"
    puts "5. Logout"
    puts "6. Exit"
    print "> "
  end

  def route__manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 7 then logout!
    when 8 then stop!
    else puts "Stop kidding..."
    end
  end

  def display_rider_menu
    puts "---------------"
    puts "-----MENU------"
    puts "---------------"
    puts "1. List my undelivered orders"
    puts "2. Mark an order as delivered"
    puts "3. Logout"
    puts "4. Exit"
    print "> "
  end

  def route__rider_action(choice)
    case choice
    when 1 then @orders_controller.list_my_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 3 then logout!
    when 4 then stop!
    else puts "Stop kidding..."
    end
  end

  def stop!
    @running = false
  end

  def logout!
    @employee = nil
  end
end