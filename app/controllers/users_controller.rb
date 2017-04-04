class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :flash_clear, only: [ :new, :show, :edit, :update, :create ]
  before_action :set_user, only: [ :show, :edit, :destroy, :update, :edit_password, :update_password ]
  before_action :set_variable, only: [ :new, :show, :edit, :update, :delete_group, :add_group ]
  before_action :sleep_now, only: [ :new, :show, :edit, :update ]
  before_action :set_for_edit_form, only: [ :show, :edit ]

  MINIMAL_NAME_SIZE = 4
  
  def index
    @users = User.page(params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update(users_params)
      redirect_to users_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render 'edit'
    end
  end
  
  def delete_group
    user_groups = UserGroup.find("#{params[:user_group_id]}")
    @user = User.find(user_groups.user_id)
    user_groups.destroy
    set_for_edit_form
    render 'edit'
  end
  
  def edit_password
    @title = t('.title', name: @user.initials)
  end
  
  def update_password
    if can_current_user_change_password_this_user?(@user)
      unless @user.update(user_password)
        flash[:danger] = @user.errors.full_messages.to_sentence
      else
        flash[:success] = t('.successful', name: @user.initials)
      end
    else
      flash[:danger] = t('.danger', name: @user.initials)
    end
    redirect_to root_path
  end
  
  def create
    @user = User.new(users_params)
    if @user.save
      redirect_to users_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render 'new'
    end
  end
  
  def destroy
    if admin?
      if @user.id == 1
        flash[:danger] = t('.danger_admin', name: @user.initials)
      else
        flash[:notice] = t('.notice', name: @user.initials)
        @user.destroy
      end
    else
      flash[:danger] = t('.danger')
    end
    redirect_to users_path
  end
  
  def add_group
    @user = User.find(params[:user_id])
    UserGroup.create(user_id: params[:user_id], group_id: params[:group_id])
    set_for_edit_form
    render 'edit'
  end
  
  private
  
  def set_for_edit_form
    @new_group = UserGroup.new
    @user_groups = UserGroup.where("user_id = #{@user.id}")
    @groups = Group.where.not(id: @user_groups.map(&:group_id))
  end
  
  def can_current_user_change_password_this_user?(user)
    return (user.id != 1 && ((current_user.id == user.id) || admin?)) ? true : false
  end
  
  def users_params
    params.require(:user).permit( :username, :email, :structure_id, :nomenclature_id, :role, :initials )
  end
  
  def user_password
    params.require(:user).permit( :password, :password_confirmation )
  end
  
  def set_variable
    @structures = Structure.all.collect{|n| n.name = parent_structure(n) + n.name; n}
    @nomenclatures = Nomenclature.all.collect{|n| n.title = parent_nomenclature(n) + n.title; n}
  end
  
  def parent_nomenclature(n)
    if n.nomenclature_id.nil?
      return ""
    else
      parent = Nomenclature.find(n.nomenclature_id)
      if parent.nomenclature_id.nil?
        return "#{parent.title}\\"
      else
        return parent_nomenclature(parent) + "#{parent.title}\\"
      end
    end
  end
  
  def parent_structure(n)
    if n.structure_id.nil?
      return ""
    else
      parent = Structure.find(n.structure_id)
      if parent.structure_id.nil?
        return "#{parent.name}\\"
      else
        return parent_structure(parent) + "#{parent.name}\\"
      end
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def sleep_now
    sleep PAUSE_FOR_RESPONSE
  end
  
  def flash_clear
    flash.clear
  end
end
