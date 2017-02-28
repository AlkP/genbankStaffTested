class CreateNomenclatures < ActiveRecord::Migration[5.0]
  def change
    create_table :nomenclatures do |t|
      t.references  :nomenclature, index: true
      
      t.string  :title
      t.integer :position

      t.timestamps
    end
  end
end
