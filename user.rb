require 'bcrypt'

class User < ActiveRecord::Base

  include BCrypt

  def password
    @password ||= Password.new(encrypted_password)
  end

  def password=(password)
    @password = Password.create(password)
    self.encrypted_password = @password
  end

end