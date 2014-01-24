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
    UserSession.create(User.first);
  end


  def random_new_user
    email = Digest::MD5.hexdigest(Time.now.ctime)+"@automatictest.de"
    password = Digest::MD5.hexdigest(Time.now.ctime)
    password_confirmation = password
    user = User.new(:email => email, :password => password, :password_confirmation => password_confirmation)
    return user



  end

end
