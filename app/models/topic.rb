class Topic < ActiveRecord::Base
  attr_accessible :title, :body, :predecessor

  has_and_belongs_to_many :tags
  has_many :comments

end
