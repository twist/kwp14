class Topic < ActiveRecord::Base
  attr_accessible :title, :body, :predecessor

  has_and_belongs_to_many :tags
  has_many :comments
  has_many :votes

  def setup
    @rating
  end

  def rating
    self[:rating].nil? ? recalculate_rating : self[:rating]
    
  end
    
  def recalculate_rating
    if votes.size == 0
      return @rating = 0
    end

    sum_of_votes = 0
    votes.each do |v|
      v.value = 0 if v.value.nil?
      sum_of_votes += v.value
    end
    topic_rating = sum_of_votes / votes.size
    write_attribute(:rating, topic_rating.round(2));
  end

  def date_of_last_comment
    comments.last.nil? ?  Time.new(2002) : comments.last.created_at
  end

  def has_tag(tag)
    tags.each do |t|
      if t.title == tag
        return true
      end
    end
    return false

  end

  def votecount
    return votes.size
  end




end
