class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.references  :group, index: true
      
      t.string  :title
      t.integer :position

      t.timestamps
    end
  end
end
