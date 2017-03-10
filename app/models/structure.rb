class Structure < ApplicationRecord
  has_many :user
  
  validates :name, presence: true
  validates :name, length: { minimum: 4 }
  
  paginates_per 15
  
  def avalable_to_delete?
    Structure.where( "structure_id = #{self.id}").first.nil?
  end
end
