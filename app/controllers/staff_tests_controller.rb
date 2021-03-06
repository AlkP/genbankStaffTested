class StaffTestsController < ApplicationController
  before_action :set_staff_test, only: [ :show, :edit, :update, :destroy ]
  
  def index
    @staff_tests = StaffTest.all.page(params[:page])
  end
  
  def new
    @staff_test = StaffTest.new
  end
  
  def show
  end
  
  def edit
  end
  
  def destroy
    @staff_test.destroy
    redirect_to staff_tests_path
  end
  
  def create
    staff_test = StaffTest.new(staff_tests_params)
    staff_test.save
    redirect_to staff_test_path(staff_test)
  end
  
  def update
    staff_test = @staff_test.update(staff_tests_params)
    if staff_test
      redirect_to staff_test_path(@staff_test)
    else
      render edit
    end
  end
  
  private
  
  def set_staff_test
    @staff_test = StaffTest.find(params[:id])
  end
  
  def staff_tests_params
    params[:staff_test][:name] = 'Наименование' if params[:staff_test].nil? || params[:staff_test][:name].blank?
    params.require(:staff_test).permit( :name, :description )
  end
end
