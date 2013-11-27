class AddFirstAndLastName < ActiveRecord::Migration
  def up
    change_table :users do |u|
      u.string :first_name
      u.string :last_name
    end
  end

  def down
  end
end
