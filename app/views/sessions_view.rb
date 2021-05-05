require_relative 'base_view'

class SessionsView < BaseView
  def signed_in_successfully
    puts "Successfully logged in!"
  end

  def wrong_credentials
    puts "Wrong credentials, try again!"
  end

  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username}"
    end
  end
end