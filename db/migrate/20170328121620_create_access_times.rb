class CreateAccessTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :access_times do |t|
      t.string    :name
      t.datetime  :from
      t.datetime  :to
      
      t.integer   :duration_days
      t.integer   :duration_hours
      t.integer   :duration_minutes
      
      t.integer   :break                  # Колличество разрешенных пауз на тест
      t.boolean   :continuous_time_break  # Заданное время: если true - на все 
                                          # паузы в сумме, false - заданно для 
                                          # каждой паузы
      t.integer   :break_days
      t.integer   :break_hours
      t.integer   :break_minutes
      
      t.references :staff_test,  index: true
      
      t.timestamps
    end
  end
end
