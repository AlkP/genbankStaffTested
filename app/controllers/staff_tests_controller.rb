class StaffTestsController < ApplicationController
  def index
    @staff_tests = StaffTest.all.page(params[:page])
  end
  
  def new
    @staff_test = StaffTest.new
  end
  
  def create
    staff_test = StaffTest.new(staff_tests_params)
    if staff_test.save
      redirect_to new_staff_test_path
    else
      flash[:danger] = "Жопа"
      render 'new'
    end
  end
  
  def show
  end
  
  private
  
  def staff_tests_params
    params.require(:staff_test).permit( :description)
  end
end
