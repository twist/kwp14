require 'test_helper'
require 'authlogic/test_case'

class TopicsControllerTest < ActionController::TestCase

  def setup

    activate_authlogic
    user_login
  end

  def test_index

    get :index
    assert_response :success
    assert_match "Themen", @response.body

    topics = Topic.all();

    #test if there is at least one topic shown
    @user = User.first
    assert_match(topics.first.body, @response.body);

    #test link to TopicController::show
    assert_match(topic_path(topics.first.id), @response.body); 

  end


  def test_view

    topic = Topic.first();
    get :show, :id => topic.id
    assert_response :success
    
    #test link back to index
    assert_match(topics_path, @response.body); 

    #assert topic is shown
    assert_match(topic.body, @response.body); 



  end
end
