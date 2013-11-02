class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.string :title
      t.string :body
      t.integer :predecessor

      t.timestamps
    end
  end
end
