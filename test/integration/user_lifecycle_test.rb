require 'test_helper'

class UserLifecycleTest < ActionDispatch::IntegrationTest

  def test_not_logged_in

    get '/'
    assert_response :success
    assert_match("registrieren", @response.body)

  end
end

