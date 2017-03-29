class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :flash_clear, only: [ :new, :show, :edit, :update, :create ]
  before_action :sleep_now, only: [ :new, :show, :edit, :update ]
  before_action :find_role, only: [ :show, :edit, :destroy, :update ]
  
  MINIMAL_NAME_SIZE = 4
  
  def index
    @search = 'roles/search'
    @roles = Role.page(params[:page])
  end
  
  def new
    @role = Role.new
  end
  
  def show
  end
  
  def create
    @role = Role.new(roles_params)
    if @role.name.size >= MINIMAL_NAME_SIZE && @role.name_allowable? && @role.save
      redirect_to roles_path
    else
      flash[:danger] = set_error(@role)
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    role = Role.new(roles_params)
    if role.name.size >= MINIMAL_NAME_SIZE && role.name_allowable? && @role.avalable_to_edit? && @role.update(roles_params)
      redirect_to roles_path
    else
      flash[:danger] = set_error(role)
      render 'edit'
    end
  end
  
  def destroy
    if @role.avalable_to_edit?
      @role.destroy
    else
      flash[:danger] = t('.danger', name: @role.name )
    end
    redirect_to roles_path( :page => params[:page] )
  end
  
  private
  
  def roles_params
    params.require(:role).permit( :name)
  end
  
  def find_role
    @role = Role.find(params[:id])
  end
  
  def set_error(role)
    return t('.set_error_double') unless role.name_allowable?
    return t('.set_error_length', length: MINIMAL_NAME_SIZE) if role.name.size < MINIMAL_NAME_SIZE
    return t('.set_error')
  end
  
  def sleep_now
    sleep PAUSE_FOR_RESPONSE
  end
  
  def flash_clear
    flash.clear
  end
end
