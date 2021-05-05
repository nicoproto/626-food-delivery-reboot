require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = [] # where I'm storing the employees instances
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @employees
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  private

  def save_csv
    # We don't need options here, we are writting the headers manually
    CSV.open(@csv_file, "wb") do |csv|
      # 1. Write the headers of the csv file
      csv << ["id", "username", "password", "role"]
      # 2. Write all instances of employee in the csv file
      @employees.each do |employee|
        csv << [employee.id, employee.username, employee.password, employee.role]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      loaded_employee = Employee.new(row)
      @employees << loaded_employee
    end
    @next_id = @employees.last.id + 1 unless @employees.empty?
  end
end
