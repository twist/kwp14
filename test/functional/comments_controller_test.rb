require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  def test_new

    get :new
    assert_response :success
    assert_match("form" , @response.body);

  end
end
