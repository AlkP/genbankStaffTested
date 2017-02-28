class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable, :validatable
  # :recoverable, :registerable, :rememberable, 
  devise :database_authenticatable, :trackable, :timeoutable
  
  belongs_to :role
  
  def admin?
    self.role.name.underscore.to_sym == :admin
  end
  
  def manager?
    self.role.name.underscore.to_sym == :manager
  end
end
