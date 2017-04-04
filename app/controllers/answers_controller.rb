class AnswersController < ApplicationController
  before_action :set_answer, only: [ :update, :destroy, :edit ]
  before_action :set_question, only: [ :destroy, :edit ]
  
  def new
    @answer = Answer.new
    @question = Question.find(params[:id])
  end
  
  def create
    @answer = Answer.new(answers_params)
    @question = @answer.question
    unless @answer.save
      render 'new'
    end
    @answers = Answer.where(question: @question)
  end
  
  def destroy
    @answer.destroy
    @answers = Answer.where(question: @question)
  end
  
  def edit
  end
  
  def update
    @answer.update(answers_params)
    @question = @answer.question
    @answers = Answer.where(question: @question)
  end
  
  private
  
  def answers_params
    params.require(:answer).permit( :name, :question_id, :correct )
  end
  
  def set_answer
    @answer = Answer.find(params[:id])
  end
  
  def set_question
    @question = @answer.question
  end
  
end
