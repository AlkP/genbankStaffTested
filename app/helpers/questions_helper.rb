module QuestionsHelper
  def url_form
    if action_name.to_sym == :new
      staff_test_questions_path(@staff_test)
    else
      staff_test_question_path(@staff_test, @question)
    end
  end
end
