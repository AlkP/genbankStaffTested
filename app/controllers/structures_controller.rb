class StructuresController < ApplicationController
  before_action :authenticate_user!
  before_action { flash.clear }
  before_action :sleep_now, only: [ :new, :show, :edit, :update ]
  before_action :find_structure, only: [ :show, :edit, :destroy, :update ]
  before_action :find_parent, only: [ :new, :show, :edit, :create ]
  
  MINIMAL_NAME_SIZE = 4
  
  def index
    @search = 'structures/search'
    @structures = Structure.where('structure_id IS NULL').page(params[:page])
  end
  
  def new
    @title = 'Добавление новой точки'
    @structure = Structure.new
    @structure.structure_id = params[:id].to_i
  end
  
  def show
    @title = 'Просмотр точки'
  end
  
  def create
    @structure = Structure.new(structures_params)
    if @structure.name.size >= MINIMAL_NAME_SIZE && @structure.save
      redirect_to structures_path
    else
      @title = 'Добавление новой точки'
      flash[:danger] = set_error(@structure)
      render 'new'
    end
  end
  
  def edit
    @title = 'Редактирование точки'
  end
  
  def update
    structure = Structure.new(structures_params)
    if structure.name.size >= MINIMAL_NAME_SIZE && @structure.update(structures_params)
      redirect_to structures_path
    else
      @title = 'Редактирование роли'
      flash[:danger] = set_error(structure)
      render 'edit'
    end
  end
  
  def destroy
    if @structure.avalable_to_delete?
      @structure.destroy
    else
      flash[:danger] = "Элемент не доступен для удаления"
    end
    redirect_to structures_path( :page => params[:page] )
  end
  
  private
  
  def find_parent
    @parents = Structure.all
    @parents = @parents.where("id IS NOT #{params[:id]}") unless params[:id].nil? || action_name == "new" || action_name == "create"
  end
  
  def structures_params
    params.require(:structure).permit( :name, :structure_id, :address )
  end
  
  def find_structure
    @structure = Structure.find(params[:id])
  end
  
  def set_error(structure)
    return "Минимально допустимая длина: #{MINIMAL_NAME_SIZE} символа" if structure.name.size < MINIMAL_NAME_SIZE
  end
  
  def sleep_now
    sleep PAUSE_FOR_RESPONSE
  end
end
