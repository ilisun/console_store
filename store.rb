require "highline/import"
require_relative "app/config"
require_relative "app/models/user"
require_relative "app/models/product"
require_relative "app/models/category"
require_relative "app/models/order"
require_relative "app/menu_container"

include MenuContainer

main_menu
