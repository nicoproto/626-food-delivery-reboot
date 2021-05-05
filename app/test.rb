require_relative 'repositories/employee_repository'

repo = EmployeeRepository.new('data/employees.csv')
p repo.all