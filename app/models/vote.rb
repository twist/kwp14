class Vote < ActiveRecord::Base
  attr_accessible :topic_id, :user_id, :value

  belongs_to :topic
  belongs_to :user
end
