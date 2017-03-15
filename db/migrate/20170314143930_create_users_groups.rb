class CreateUsersGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :user_groups do |t|
      t.references :user,   index: true
      t.references :group,  index: true
    end
    
    add_index :user_groups, [:user_id, :group_id], unique: true
  end
end
