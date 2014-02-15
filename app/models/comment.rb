class Comment < ActiveRecord::Base
  attr_accessible :body, :topic_id, :user_id
  validates :body, :presence => {:message => "Bitte geben Sie ein Kommentar ein"}

  belongs_to :topic
  belongs_to :user
end
