class QuestionsController < ApplicationController
  before_action :set_staff_test, only: [ :new, :index, :show, :edit, :update, :create, :destroy ]
  before_action :set_question, only: [ :show, :edit, :update, :destroy ]
  
  def index
    @questions = Question.all.page(params[:page])
  end
  
  def new
    @question = Question.new
  end
  
  def create
    question = Question.new(questions_params)
    question.staff_test = @staff_test
    question.save
    redirect_to staff_test_questions_path(@staff_test)
  end
  
  def show
    @answers = Answer.where(question_id: @question)
  end
  
  def edit
  end
  
  def update
    question = @question.update(questions_params)
    if question
      redirect_to staff_test_question_path(@staff_test, @question)
    else
      render edit
    end
  end
  
  private
  
  def set_question
    @question = Question.find(params[:id])
  end
  
  def questions_params
    params.require(:question).permit( :description )
  end
  
  def set_staff_test
    @staff_test = StaffTest.find(params[:staff_test_id])
  end
end
