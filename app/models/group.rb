class Group < ApplicationRecord
  
  validates :title, presence: true
  validates :title, length: { minimum: 4 }
  
  paginates_per 15
  
  def avalable_to_delete?
    Group.where( "group_id = '#{self.id}'").first.nil?
  end
end
