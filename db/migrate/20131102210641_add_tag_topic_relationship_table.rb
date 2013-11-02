class AddTagTopicRelationshipTable < ActiveRecord::Migration
  def up
    create_table :tags_topics do |t|
      t.belongs_to :tag
      t.belongs_to :topic
    end
  end

  def down

  end
end
