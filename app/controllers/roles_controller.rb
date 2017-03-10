class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action { flash.clear }
  before_action :sleep_now, only: [ :new, :show, :edit, :update ]
  before_action :find_role, only: [ :show, :edit, :destroy, :update ]
  
  MINIMAL_NAME_SIZE = 4
  
  def index
    @search = 'roles/search'
    @roles = Role.page(params[:page])
  end
  
  def new
    @title = 'Добавление новой роли'
    @role = Role.new
  end
  
  def show
    @title = 'Просмотр роли'
  end
  
  def create
    @role = Role.new(roles_params)
    if @role.name.size >= MINIMAL_NAME_SIZE && @role.name_allowable? && @role.save
      redirect_to roles_path
    else
      @title = 'Добавление новой роли'
      flash[:danger] = set_error(@role)
      render 'new'
    end
  end
  
  def edit
    @title = 'Редактирование роли'
  end
  
  def update
    role = Role.new(roles_params)
    if role.name.size >= MINIMAL_NAME_SIZE && role.name_allowable? && @role.update(roles_params)
      redirect_to roles_path
    else
      @title = 'Редактирование роли'
      flash[:danger] = set_error(role)
      render 'edit'
    end
  end
  
  def destroy
    @role.destroy
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
    return 'Попытка создания дубликата' unless role.name_allowable?
    return "Минимально допустимая длина: #{MINIMAL_NAME_SIZE} символа" if role.name.size < MINIMAL_NAME_SIZE
  end
  
  def sleep_now
    sleep PAUSE_FOR_RESPONSE
  end
end
