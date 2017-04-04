module AnswersHelper
  def class_name(answer)
    if answer.correct
      'info'
    else
    'danger'
    end
  end
end
