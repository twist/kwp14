require 'test_helper'

class TopicsControllerTest < ActionController::TestCase

  def test_index

    get :index
    assert_response :success
    assert_match "Themen", @response.body

  end
end
