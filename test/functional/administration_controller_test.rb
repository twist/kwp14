require 'test_helper'

class AdministrationControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  #

  def test_index
    
    get :index
    users = User.all
    users.each do |u|
      assert_match(u.email, @response.body)
    end

    users.first.encrypt_email_and_save
    get :index
    users = User.all
    users.each do |u|
      if(u.email =~ /@/)
        assert_match(u.first_name, @response.body)
      else
        assert_no_match(/#{u.first_name}/, @response.body)
      end
    end


  end

  def test_encryption
    get :index
    users = User.all
    users.each do |u|
      assert_match(u.email, @response.body)
    end

    get :encrypt
    assert_response :redirect

    get :index
    users = User.all
    users.each do |u|
        assert_no_match(/#{u.first_name}/, @response.body)
    end


  end
end
