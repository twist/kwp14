class User < ActiveRecord::Base
  attr_accessible :crypted_password, :email, :password_salt, :persistence_token, :username, :first_name, :last_name, :password_confirmation, :password
  acts_as_authentic do |c| c.login_field = :email end
end
