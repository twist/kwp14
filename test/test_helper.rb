ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'digest/md5'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  
  def user_login(user = nil)

    user_to_login = nil
    if user.nil? 
      user_to_login = User.first()
    else 
      user_to_login = user
    end 
    UserSession.create(user_to_login)
    return user_to_login
  end

  def admin_login
    users = User.all
    users.each do |u|
      if u.has_role? 'admin'
        user_login(u)
        return true
      end
    end
    throw "No Admin found in Test Database"

  end


  def random_new_user
    email = Digest::MD5.hexdigest(Time.now.ctime)+"@automatictest.de"
    password = Digest::MD5.hexdigest(Time.now.ctime)
    password_confirmation = password
    first_name = "First_name"+Time.now.ctime
    last_name = "Second"+Time.now.ctime
    user = User.new(:first_name => first_name, :last_name => last_name,:email => email, :password => password, :password_confirmation => password_confirmation)
    return user



  end

end
