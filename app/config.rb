require "active_record"

# ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'app/db/store_db.sqlite')

ActiveRecord::Migration.class_eval do
  
  unless ActiveRecord::Base.connection.table_exists? 'users'
    create_table :users do |t|
        t.string :email,              null: false, default: ""
        t.string :encrypted_password, null: false, default: ""
        t.timestamps null: false
    end 
    add_index :users, :email,         unique: true
  end

  unless ActiveRecord::Base.connection.table_exists? 'products'
    create_table :products do |t|
        t.string  :name,              null: false, default: ""
        t.decimal :price,             precision: 10, scale: 2
        t.text    :description,       default: ""
        t.integer :category_id
        t.timestamps null: false
    end 
    add_index :products, :category_id
  end
  
  create_table :categories do |t|
      t.string :name,               null: false, default: ""
      t.timestamps null: false
  end unless ActiveRecord::Base.connection.table_exists? 'categories'

  unless ActiveRecord::Base.connection.table_exists? 'orders'
    create_table :orders do |t|
        t.integer :product_id      
        t.integer :user_id          
        t.boolean :payment,           default: false
        t.timestamps null: false
    end 
    add_index :orders, :product_id
    add_index :orders, :user_id
  end

end
