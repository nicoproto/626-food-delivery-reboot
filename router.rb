class Router
  def initialize(meals_controller, customers_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller

    @running = true
  end

  def run
    while @running
      display_menu
      choice = gets.chomp.to_i
      print `clear`
      route_action(choice)
    end
  end

  def display_menu
    puts "---------------"
    puts "-----MENU------"
    puts "---------------"
    puts "1. Add a new meal"
    puts "2. List all meals"
    puts "3. Add a new customer"
    puts "4. List all customers"
    puts "5. Exit"
  end

  def route_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then stop!
    else puts "Stop kidding..."
    end
  end

  def stop!
    @running = false
  end
end