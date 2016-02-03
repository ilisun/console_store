require "highline/import"
require_relative "config"
require_relative "user"
require_relative "menu_container"

include MenuContainer

system "clear"
say("*******************************\n* Welcome to the online store *\n*******************************")
say("\nPlease log in!")
choose do |menu|
  menu.prompt = "Your choice: "

  menu.choice :log_in do 
    new_user = Hash.new

    new_user[:email] = ask("E-mail: ")
    new_user[:password] = ask("Password: ") { |q| q.echo = false }

    user = User.find_by_email(new_user[:email])

    if user.present? && user.password == new_user[:password]
      user_menu(user)
      p new_user
    else
      say("\nSorry, username or password are incorrect. Please try again!")
      redo
    end

  end

  menu.choice :sign_up do 
    say("Not from around here, are you?") 
  end
end

