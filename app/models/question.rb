class Question < ApplicationRecord
  belongs_to :staff_test, optional: true
  has_many :answers
  
end
