require 'test_helper'

class UserLifecycleTest < ActionDispatch::IntegrationTest

 
  def setup

  end

  def test_not_logged_in

    get '/'
    assert_response :success
    assert_match("registrieren", @response.body)

  end


  def test_create_user
    
    old_user_count = User.all.length
    get 'users/new'
    assert_response :success
    assert_match('password', @response.body)
    post 'users', :user => create_new_user_data
    assert_response :redirect
    new_user_count = User.all.length
    assert_equal new_user_count, old_user_count+1





  end

  def create_new_user_data
    {
      :first_name => "Horst",
      :last_name => "Köhler",
      :password => "horsti_ist_der_beste",
      :password_confirmation => "horsti_ist_der_beste",
      :email => "horst@schland.de"
    }
  end
end

