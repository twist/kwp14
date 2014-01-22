class CreateRolesUsersTable < ActiveRecord::Migration
  def up
    create_table :roles_users do |t|
      t.belongs_to :role
      t.belongs_to :user
    end
  end

  def down
  end
end
