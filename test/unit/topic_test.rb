require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def test_relationships

    topics =  Topic.all()
    assert_not_nil topics.first.tags

  end
end
