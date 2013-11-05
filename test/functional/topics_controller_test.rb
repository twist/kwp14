require 'test_helper'

class TopicsControllerTest < ActionController::TestCase

  def test_index

    get :index
    assert_response :success
    assert_match "Themen", @response.body

    topics = Topic.all();

    assert_match(topics.first.title, @response.body);

  end


  def test_view

    topic = Topic.first();
    get :show, :id => topic.id
    assert_response :success



  end
end
