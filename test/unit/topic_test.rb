require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def test_relationships

    topics =  Topic.all()
    assert_not_nil topics.first.tags

  end

  def test_rating

    topic =  Topic.find(1)
    assert topic.votes.size > 1
    assert_equal 6.67, topic.rating

  end
end
