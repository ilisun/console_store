module MenuContainer

  def main_menu
    system "clear"
    say("\n* Welcome to the online store")
    say("\nPlease log in!")
    choose do |menu|
      menu.prompt = "Your choice: "

      menu.choice :Log_in do 
        new_user = Hash.new
        new_user[:email] = ask("E-mail: ")
        new_user[:password] = ask("Password: ") { |q| q.echo = false }

        @user = User.find_by_email(new_user[:email])
        if @user.present? && @user.password == new_user[:password]
          user_menu(@user)
        else
          say("\nSorry, username or password are incorrect. Please try again!")
          redo
        end
      end
      menu.choice :Sign_up do 
        say("Not from around here, are you?") 
      end
    end
  end

  def user_menu(user)
    system "clear"
    say("\n* Welcome to the online store")
    say("** #{user.email}")
    say("*** Store:")

    choose do |menu|
      menu.prompt = "Your choice: "

      menu.choice :Catalog do catalog_menu end
      menu.choice :Cart do show_cart(user) end
      menu.choice :Order do show_order(user) end    
      menu.choice "Back to main menu" do main_menu end
    end
  end

  def catalog_menu
    say("\nCatalog:")

    choose do |menu|
      menu.prompt = "Choice a category: "
      categories = Category.all

      categories.each do |category|  
        menu.choice "#{category.name}" do 
          product_menu(category)
        end
      end
      menu.choice "Back to main menu" do user_menu(@user) end
    end
  end

  def product_menu(category)
    say("\n#{category.name} - category.")
    products = Product.where(category_id: category.id)

    choose do |menu|
      menu.prompt = "Add product to cart: "

      products.each do |product|
        menu.choice "- #{product.name}, price: #{product.price}, description: #{product.description}" do 
          say("\nProduct add your cart!") if Order.create(product_id: product.id, user_id: @user.id)
          catalog_menu
        end
      end
      menu.choice "Back to catalog" do catalog_menu end
    end
  end

  def show_cart(user)
    # orders = user.orders.select {|order| order.payment != true}
    orders = Order.where("user_id = ? AND payment <> ?", 1, true)
    
    if orders.present?
      say("\nYour cart:")

      orders.each do |ord|
        product = Product.find(ord.product_id)
        say("- #{product.name}, price: #{product.price}, description: #{product.description}")
      end

      if agree("Pay for purchases?  ", true)
        orders.each { |ord| ord.update_attributes(payment: true) }
      end
      user_menu(user)
    else
      say("\nYour cart empty!")
      choose do |menu|
        menu.prompt = "Your choice: "
        menu.choice "Back to user menu" do user_menu(user) end
      end
    end
  end

  def show_order(user)
    if user.orders.present?
      say("\nYour orders:")

      user.orders.each do |ord|
        product = Product.find(ord.product_id)
        say("- #{product.name}, price: #{product.price}, description: #{product.description}, payment: #{ord.payment}")
      end

      choose do |menu|
        menu.prompt = "Your choice: "
        menu.choice "Back to user menu" do user_menu(user) end
      end
    end
  end

end