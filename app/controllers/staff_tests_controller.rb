class StaffTestsController < ApplicationController
  before_action :set_staff_test, only: [ :show, :edit, :update ]
  
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
  
  def create
    staff_test = StaffTest.new(staff_tests_params)
    staff_test.save
    redirect_to staff_test_path(staff_test)
  end
  
  def update
    staff_test = @staff_test.update(staff_tests_params)
    redirect_to staff_test_path(@staff_test)
  end
  
  private
  
  def set_staff_test
    @staff_test = StaffTest.find(params[:id])
  end
  
  def staff_tests_params
    params.require(:staff_test).permit( :name, :description )
  end
end
