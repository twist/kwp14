require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  def test_login
    user = random_new_user
    user.save!
    post :create, {:user_session => {:email => user.email, :password => user.password}}
    assert_response :redirect

    #



  end

  def test_login_email_encrypted

    user = random_new_user
    user.save!
    original_email = user.email
    user.encrypt_email_and_save
    assert_equal(user.email, Digest::MD5.hexdigest(original_email))

    post :create, {:user_session => {:email => original_email, :password => user.password}}
    pp @response.body
    assert_response :redirect
  end
  
end
