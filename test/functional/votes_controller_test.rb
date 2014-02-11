require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  setup do
    @vote = votes(:one)
  end


  def test_vote_create
    topic = Topic.all.last
    user = User.all.last
    rating_old = topic.rating

    post :create , :vote => {:topic_id => topic.id, :user_id => user.id, :value => "4"}
    assert_response :redirect

    topic = Topic.all.last
    assert_match("4.0", "#{topic.rating}");



  end
end
