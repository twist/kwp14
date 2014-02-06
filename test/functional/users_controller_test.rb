require 'test_helper'
require 'authlogic/test_case'

class UsersControllerTest < ActionController::TestCase


  def setup
    activate_authlogic
    user_login
  end


  def test_delete_user_no_admin

    @users = User.all
   get users_path(@users.last.id), :method => :delete
  end
end
