class AnswersController < ApplicationController
  def create
    @question = Question.find params[:question_id]
    answer_params = params.require(:answer).permit(:body)
    @answer = Answer.new answer_params
    @answer.question = @question
    if @answer.save
      # render json: params
      redirect_to questions_path(@question), notice: "Thanks for answering!"
    else
      flash[:alert] = "not saved"
      # this will render the show.html.erb inside /views/questions
      render "/questions/show"
    end

  end

  def destroy
    question = Question.find params[:question_id]
    answer = question.answers.find params[:id]
    answer.destroy
    redirect_to question_path(question), notice: "Answer Deleted!"
  end



end
