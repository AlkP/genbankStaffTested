class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text    :description
      
      t.references :staff_test,  index: true

      t.timestamps
    end
  end
end
