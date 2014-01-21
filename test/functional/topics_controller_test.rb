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
    assert_match "Aufgaben und Teilziele", @response.body

    topics = Topic.all();

    #test if there is at least one topic shown
    @user = User.first
    assert_match(topics.first.body, @response.body);

    #test link to TopicController::show
    assert_match(topic_path(topics.first.id), @response.body); 

  end

  def test_sort_and_filter

    get :index
    assert_response :success
    assert_match "Aufgaben und Teilziele", @response.body
    std_index = @response.body
    topics = Topic.all
    #topics should be sorted by id
    assert_match(/#{topics.first.body}.*#{topics.last.body}/m, std_index)

    get :index, {:sort => "Bewertungen"}
    assert_response :success
    sort_index = @response.body

    #find two topics with t1.rating > t2.rating and t1.id < t2.id
    #and high_topic = t1, low_topic = t2
    consecutive_topics = find_consecutive_rated_topics(topics)


    assert_not_equal(std_index, sort_index)
    assert_match(/#{consecutive_topics.first.body}.*#{consecutive_topics.last.body}/m, sort_index)

    #test if the state is preserved
    get :index
    sort_index_2 = @response.body
    assert_equal(sort_index_2, sort_index)

    get :index, {:sort => "no"}
    sort_index_no = @response.body
    assert_equal(sort_index_no, std_index)



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

    #find two topics with t1.rating > t2.rating and t1.id < t2.id
    #and high_topic = t1, low_topic = t2
  def find_consecutive_rated_topics(base)
    high_topic = base.first
    low_topic = nil
    base.each do |t|
      if high_topic.rating > t.rating and high_topic.id < t.id
        low_topic = t
        break
     elsif t.rating > high_topic.rating
        low_topic = high_topic
        high_topic = t
        break
      end
    end
    return [high_topic, low_topic]
  end
end
