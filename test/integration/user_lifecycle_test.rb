require 'test_helper'
require 'authlogic/test_case'

class UserLifecycleTest < ActionDispatch::IntegrationTest

 
  def setup
    activate_authlogic
    @http_referer = '/topics'
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

  def test_create_user_no_name

    assert false, 'test needs to be written'

  end

  def test_all_from_login_to_logout

    @user = User.first
    @topic = Topic.first
    get 'topics/show', {:id => @topic.id}, {'HTTP_REFERER' => @http_referer}
    assert_response :redirect
    assert_match @http_referer, @response.body
    get @http_referer
    assert_match "Bitte melden Sie sich an um diese Funktionalität zu nutzen", @response.body

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
    post 'votes', {:vote => { :value => 3,
                            :user_id => @user.id,
                            :topic_id => @topic.id} },
                {'HTTP_REFERER' => "topics/#{@topic.id}"}
    @vote = Vote.last
    assert_response :redirect
    get topic_path(@topic.id),{}, {'HTTP_REFERER' => @http_referer}
    assert_response :success

    assert_match("<input checked=\"checked\" id=\"vote_value_3\"", @response.body);
    @new_vote_count = Vote.all.count
    assert_equal(@old_vote_count+1, @new_vote_count)


    @old_vote_count = Vote.all.count
    put vote_path(@vote.id), {:vote => { :value => 5,
                            :user_id => @user.id,
                            :topic_id => @topic.id} },
                {'HTTP_REFERER' => "topics/#{@topic.id}"}
    assert_response :redirect
    get topic_path(@topic.id),{}, {'HTTP_REFERER' => @http_referer}
    assert_response :success

    assert_match("<input checked=\"checked\" id=\"vote_value_5\"", @response.body);
    @new_vote_count = Vote.all.count
    assert_equal(@old_vote_count, @new_vote_count)


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

