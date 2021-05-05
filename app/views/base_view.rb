class BaseView
  def ask_user_for(stuff)
    puts "#{stuff}?"
    print "> "
    gets.chomp
  end
end