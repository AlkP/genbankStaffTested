class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :set_title, only: [ :new, :show, :edit, :update, :create ]
  
  PAUSE_FOR_RESPONSE = 1
  
  protected
  
  def set_title
    @title = t('.title')
  end
  
  def admin?
    current_user.nil? ? false : current_user.admin?
  end
  
  def manager?
    current_user.nil? ? false : current_user.manager?
  end
  
  helper_method :admin?, :manager?
end
