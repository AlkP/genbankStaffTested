class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string  :name
      t.boolean :correct
      
      t.references :question,  index: true
      
      t.timestamps
    end
  end
end
