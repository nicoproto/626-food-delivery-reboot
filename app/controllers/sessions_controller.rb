require_relative "../views/sessions_view"

class SessionsController
  def initialize(employee_repository)
    @view = SessionsView.new
    @employee_repository = employee_repository
  end

  def sign_in
    # 1. Ask user for username
    username = @view.ask_user_for(:username)
    # 2. Ask user for password
    password = @view.ask_user_for(:password)
    # 3. Find the employee with the username
    employee = @employee_repository.find_by_username(username)
    # 4. Compare the password given with the one in my repository

    if employee && employee.password == password
      # Logged in!
      @view.signed_in_successfully
      return employee
    else
      @view.wrong_credentials
      sign_in # Recursive call
    end
  end
end