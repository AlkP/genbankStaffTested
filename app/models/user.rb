class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable, :validatable
  # :recoverable, :registerable, :rememberable, 
  devise :database_authenticatable, :trackable, :timeoutable, :lockable
  
  belongs_to :nomenclature, optional: true
  belongs_to :structure, optional: true
  
  has_many :user_groups
  has_many :groups, through: :user_groups
  
  enum role: [ :admin, :manager, :user ]
  
  paginates_per 15
  
  def admin?
    self.role.to_sym == :admin
  end
  
  def manager?
    self.role.to_sym == :manager
  end
  
  def avalable_to_delete?
    true
  end
end
