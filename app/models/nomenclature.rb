class Nomenclature < ApplicationRecord
  has_many :users
  
  validates :title, presence: true
  validates :title, length: { minimum: 6 }
  
  paginates_per 15
  
  def avalable_to_delete?
    Nomenclature.where( "nomenclature_id = #{self.id}").first.nil?
  end
end
