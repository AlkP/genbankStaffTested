class StaffTest < ApplicationRecord
  has_many :access_times
  has_many :questions
  
end
