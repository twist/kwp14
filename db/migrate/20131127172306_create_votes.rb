class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :topic_id
      t.float :value

      t.timestamps
    end
  end
end
