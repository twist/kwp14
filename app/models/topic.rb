class Topic < ActiveRecord::Base
  attr_accessible :title, :body, :predecessor

  has_and_belongs_to_many :tags
  has_many :comments
  has_many :votes

  def rating

    if votes.size == 0
      return 0
    end

    sum_of_votes = 0
    votes.each do |v|
      sum_of_votes += v.value
    end
    topic_rating = sum_of_votes / votes.size
    topic_rating.round(2)

  end

  def has_tag(tag)
    tags.each do |t|
      if t.title == tag
        return true
      end
    end
    return false

  end




end
