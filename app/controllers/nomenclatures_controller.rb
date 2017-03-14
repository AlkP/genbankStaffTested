class NomenclaturesController < ApplicationController
  before_action :authenticate_user!
  before_action :flash_clear, only: [ :new, :show, :edit, :update, :create ]
  before_action :set_title, only: [ :new, :show, :edit, :update, :create ]
  before_action :sleep_now, only: [ :new, :show, :edit, :update ]
  before_action :find_nomenclature, only: [ :show, :edit, :destroy, :update ]
  before_action :find_parent, only: [ :new, :show, :edit, :create ]
  
  MINIMAL_NAME_SIZE = 6
  
  def index
    @search = 'nomenclatures/search'
    @nomenclatures = Nomenclature.where('nomenclature_id IS NULL').page(params[:page])
  end
  
  def new
    @nomenclature = Nomenclature.new
    @nomenclature.nomenclature_id = params[:id].to_i
  end
  
  def show
  end
  
  def create
    @nomenclature = Nomenclature.new(nomenclatures_params)
    if @nomenclature.title.size >= MINIMAL_NAME_SIZE && @nomenclature.save
      redirect_to nomenclatures_path
    else
      flash[:danger] = set_error(@nomenclature)
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    nomenclature = Nomenclature.new(nomenclatures_params)
    if nomenclature.title.size >= MINIMAL_NAME_SIZE && @nomenclature.update(nomenclatures_params)
      redirect_to nomenclatures_path
    else
      flash[:danger] = set_error(nomenclature)
      render 'edit'
    end
  end
  
  def destroy
    if @nomenclature.avalable_to_delete?
      @nomenclature.destroy
    else
      flash[:danger] = t('.danger', title: @nomenclature.title )
    end
    redirect_to nomenclatures_path( :page => params[:page] )
  end
  
  private
  
  def set_title
    @title = t('.title')
  end
  
  def find_parent
    @parents = Nomenclature.all
    @parents = @parents.where("id NOT IN (#{params[:id]})") unless params[:id].nil? || action_name == "new" || action_name == "create"
  end
  
  def nomenclatures_params
    params.require(:nomenclature).permit( :title, :nomenclature_id )
  end
  
  def find_nomenclature
    @nomenclature = Nomenclature.find(params[:id])
  end
  
  def set_error(nomenclature)
    return t('.set_error', length: MINIMAL_NAME_SIZE ) if nomenclature.title.size < MINIMAL_NAME_SIZE
  end
  
  def sleep_now
    sleep PAUSE_FOR_RESPONSE
  end
  
  def flash_clear
    flash.clear
  end
end
