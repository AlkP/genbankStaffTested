class Role < ApplicationRecord
  has_many :user
  
  validates :name, presence: true
  validates :name, length: { minimum: 4 }
  validates :name, uniqueness: true
  
  paginates_per 7
  
  def name_allowable?
    if Role.where(" name = ? ", self.name).count == 0 
      true
    else
      false
    end
  end
  
  def avalable_to_edit?
    !['admin', 'manager', 'user'].include?(self.name)
  end
end
