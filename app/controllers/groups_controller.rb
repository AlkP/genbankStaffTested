class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action { flash.clear }
  before_action :sleep_now, only: [ :new, :show, :edit, :update ]
  before_action :find_group, only: [ :show, :edit, :destroy, :update ]
  before_action :find_parent, only: [ :new, :show, :edit, :create ]
  
  MINIMAL_NAME_SIZE = 4
  
  def index
    @search = 'groups/search'
    @groups = Group.where('group_id IS NULL').page(params[:page])
  end
  
  def new
    @title = 'Добавление новой должности'
    @group = Group.new
    @group.group_id = params[:id].to_i
  end
  
  def show
    @title = 'Просмотр должности'
  end
  
  def create
    @group = Group.new(groups_params)
    if @group.title.size >= MINIMAL_NAME_SIZE && @group.save
      redirect_to groups_path
    else
      @title = 'Добавление новой должности'
      flash[:danger] = set_error(@group)
      render 'new'
    end
  end
  
  def edit
    @title = 'Редактирование роли'
  end
  
  def update
    group = Group.new(groups_params)
    if group.title.size >= MINIMAL_NAME_SIZE && @group.update(groups_params)
      redirect_to groups_path
    else
      @title = 'Редактирование роли'
      flash[:danger] = set_error(group)
      render 'edit'
    end
  end
  
  def destroy
    if @group.avalable_to_delete?
      @group.destroy
    else
      flash[:danger] = "Элемент не доступен для удаления"
    end
    redirect_to groups_path( :page => params[:page] )
  end
  
  private
  
  def find_parent
    @parents = Group.all
    @parents = @parents.where("id IS NOT #{params[:id]}") unless params[:id].nil? || action_name == "new" || action_name == "create"
  end
  
  def groups_params
    params.require(:group).permit( :title, :group_id )
  end
  
  def find_group
    @group = Group.find(params[:id])
  end
  
  def set_error(group)
    return "Минимально допустимая длина: #{MINIMAL_NAME_SIZE} символа" if group.title.size < MINIMAL_NAME_SIZE
  end
  
  def sleep_now
    sleep PAUSE_FOR_RESPONSE
  end
end
