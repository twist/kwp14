class TopicAddRatingColumn < ActiveRecord::Migration
  def up

    change_table :topics do |u|
      u.float :rating
    end
  end

  def down
  end
end
