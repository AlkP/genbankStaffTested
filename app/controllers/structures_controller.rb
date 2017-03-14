class StructuresController < ApplicationController
  before_action :authenticate_user!
  before_action :flash_clear, only: [ :new, :show, :edit, :update, :create ]
  before_action :set_title, only: [ :new, :show, :edit, :update, :create ]
  before_action :sleep_now, only: [ :new, :show, :edit, :update ]
  before_action :find_structure, only: [ :show, :edit, :destroy, :update ]
  before_action :find_parent, only: [ :new, :show, :edit, :create ]
  
  MINIMAL_NAME_SIZE = 4
  
  def index
    @search = 'structures/search'
    @structures = Structure.where('structure_id IS NULL').page(params[:page])
  end
  
  def new
    @structure = Structure.new
    @structure.structure_id = params[:id].to_i
  end
  
  def show
  end
  
  def create
    @structure = Structure.new(structures_params)
    if @structure.name.size >= MINIMAL_NAME_SIZE && @structure.save
      redirect_to structures_path
    else
      flash[:danger] = set_error(@structure)
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    structure = Structure.new(structures_params)
    if structure.name.size >= MINIMAL_NAME_SIZE && @structure.update(structures_params)
      redirect_to structures_path
    else
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
  
  def set_title
    @title = t('.title')
  end
  
  def find_parent
    @parents = Structure.all
    @parents = @parents.where("id NOT IN (#{params[:id]})") unless params[:id].nil? || action_name == "new" || action_name == "create"
  end
  
  def structures_params
    params.require(:structure).permit( :name, :structure_id, :address )
  end
  
  def find_structure
    @structure = Structure.find(params[:id])
  end
  
  def set_error(structure)
    return t('.set_error', length: MINIMAL_NAME_SIZE) if structure.name.size < MINIMAL_NAME_SIZE
  end
  
  def sleep_now
    sleep PAUSE_FOR_RESPONSE
  end
  
  def flash_clear
    flash.clear
  end
end
