require 'test_helper'
require 'authlogic/test_case'

class CommentsControllerTest < ActionController::TestCase

  def setup

    activate_authlogic
    user_login
  end

  def test_new

    get :new
    assert_response :success
    assert_match("form" , @response.body);

  end
end
