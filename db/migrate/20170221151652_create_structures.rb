class CreateStructures < ActiveRecord::Migration[5.0]
  def change
    create_table :structures do |t|
      t.references  :structure, index: true
      
      t.string  :name
      t.string  :address
      t.integer :position
      
      t.timestamps
    end
  end
end
