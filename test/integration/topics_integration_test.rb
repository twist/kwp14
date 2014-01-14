require 'test_helper'
require 'authlogic/test_case'

class TopicsIntegrationTest < ActionDispatch::IntegrationTest

 
  def setup
    activate_authlogic
    @http_referer = '/topics'
  end

  def test_illegal_voting

    @user = User.first
    @topic = Topic.first
    get new_user_session_path
    assert_match "Password", @response.body
    post user_sessions_path, :user_session => { :email => @user.email,
                            :password => 'abcd'} 
    assert_response :redirect
    assert_match @http_referer, response.body

    get 'topics/', {:id => @topic.id}, {'HTTP_REFERER' => @http_referer}
    assert_response :success
    assert_match(Topic.all.first.body, @response.body)
    assert_match('bewerten', @response.body);

    @old_vote_count = Vote.all.count

    post 'votes', {:vote => { :value => nil,
                            :user_id => @user.id,
                            :topic_id => @topic.id} },
                {'HTTP_REFERER' => "topics/#{@topic.id}"}
    assert_response :redirect

    @vote = Vote.last
    assert_response :redirect

    get topic_path(@topic.id),{}, {'HTTP_REFERER' => @http_referer}
    assert_response :success

    assert_match("keine leeren Bewertungen", @response.body)


  end
end
