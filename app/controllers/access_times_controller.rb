class AccessTimesController < ApplicationController
  before_action :set_staff_test, only: [ :new, :index, :show, :edit, :update, :create, :destroy ]
  before_action :set_access_time, only: [ :show, :edit, :update, :destroy ]
  before_action :set_title, only: [ :new, :show, :edit, :update, :create ]
  
  def index
    @access_times = AccessTime.where(staff_test: params[:staff_test_id]).page(params[:page])
  end
  
  def new
    @access_time = AccessTime.new
    @access_time.duration_days    = 0
    @access_time.duration_hours   = 0
    @access_time.duration_minutes = 0
    @access_time.break = 0
    @access_time.break_days    = 0
    @access_time.break_hours   = 0
    @access_time.break_minutes = 0
    @access_time.from = DateTime.new(Date.today.year, Date.today.month, Date.today.day, 8, 30, 0)
    @access_time.to = DateTime.new(Date.today.year + 1, Date.today.month, Date.today.day, 18, 30, 0)
  end
  
  def create
    @access_time = AccessTime.new(access_times_params)
    @access_time.staff_test = @staff_test
    if @access_time.save
      redirect_to staff_test_access_times_path(@staff_test)
    else
      flash[:danger] = set_error(@access_time)
      render 'new'
    end
  end
  
  def update
    access_time = @access_time.update(access_times_params)
    if access_time
      redirect_to staff_test_access_times_path(@staff_test)
    else
      render 'edit'
    end
  end
  
  def  edit
  end
  
  def destroy
    @access_time.destroy
    redirect_to staff_test_access_times_path(@staff_test)
  end
  
  private
  
  def access_times_params
    params.require(:access_time)
      .permit(  :name, :from, :to, :duration_days, :duration_hours, 
                :duration_minutes, :break, :continuous_time_break, 
                :break_days, :break_hours, :break_minutes)
  end
  
  def set_title
    @title = t('.title')
  end
  
  def set_staff_test
    @staff_test = StaffTest.find(params[:staff_test_id])
  end
  
  def set_access_time
    @access_time = AccessTime.find(params[:id])
  end
end
