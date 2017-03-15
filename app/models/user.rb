class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable, :validatable
  # :recoverable, :registerable, :rememberable, 
  devise :database_authenticatable, :trackable, :timeoutable
  
  belongs_to :role, optional: true
  belongs_to :nomenclature, optional: true
  belongs_to :structure, optional: true
  
  has_many :user_groups
  has_many :groups, through: :user_groups
  
  paginates_per 15
  
  def admin?
    self.role.name.underscore.to_sym == :admin
  end
  
  def manager?
    self.role.name.underscore.to_sym == :manager
  end
  
  def avalable_to_delete?
    true
  end
end
