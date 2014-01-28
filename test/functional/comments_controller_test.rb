require 'test_helper'
require 'authlogic/test_case'

class CommentsControllerTest < ActionController::TestCase

  def setup

    activate_authlogic
    @user = user_login
  end

  def test_new

    get :new
    assert_response :success
    assert_match("form" , @response.body);

  end

  def test_create

    get :new
    assert_response :success
    topic = Topic.first
    old_comments = Comment.all

    post :create, {:comment => {:topic_id => topic.id, :user_id => @user.id, :body => "automated test"}}
    assert_response :redirect
    assert_equal(old_comments.size + 1, Comment.all.size)

    


  end
end
