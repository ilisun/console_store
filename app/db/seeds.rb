require_relative "../config"
require_relative "../models/user"
require_relative "../models/category"
require_relative "../models/product"

category_list = ['Clothing', 'Shoes', 'Kids', 'Jewelry']
user_list     = [ ['user0@m.ru', 'Qwerty12'], 
                  ['user1@m.ru', 'Qwerty12'], 
                  ['user2@m.ru', 'Qwerty12']]
product_list  = [ ['Buffalo Jeans', '150', 'Buffalo Jeans detailing...', 'Clothing'],
                  ['Armani Jeans', '205', 'Armani Jeans detailing...', 'Clothing'],
                  ['Alfani RED Jacket', '205', 'Alfani RED Jacket detailing...', 'Clothing'],
                  ['Steve Madden Boots', '185', 'Steve Madden Boots detailing...', 'Shoes'],
                  ['Madden Bradly Boots', '173', 'Madden Bradly Boots detailing...', 'Shoes'],
                  ['Spider-Man Boys Pajamas', '49', 'Spider-Man Boys Pajamas detailing...', 'Kids'],
                  ['Michael Kors Ring', '140', 'Michael Kors Ring detailing...', 'Jewelry'],
                  ['Cubic Zirconia Ring Silver', '104', 'Cubic Zirconia Ring Silver detailing...', 'Jewelry']]

user_list.each do |email, password|
  User.create(email: email, password: password)
end

category_list.each do |category|
  Category.create(name: category)
end

product_list.each do |name, price, description, category|
  Product.create(name: name, price: price, description: description, category_id: Category.find_by(name: category).id)
end

