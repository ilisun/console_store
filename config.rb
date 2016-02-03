require "active_record"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/store_db.sqlite')

ActiveRecord::Migration.class_eval do
  create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.timestamps null: false
   end
   add_index :users, :email, unique: true

end unless ActiveRecord::Base.connection.table_exists? 'users'