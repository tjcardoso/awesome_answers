class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question
  before_action :find_and_authorize_answer, only: :destroy

  include QuestionsAnswersHelper
  helper_method :user_like


  def create
    # sleep 5
    answer_params = params.require(:answer).permit(:body)
    @answer = Answer.new answer_params
    @answer.question = @question
    @answer.user = current_user
    respond_to do |format|  # add for ajax
      if @answer.save
        # render json: params
        AnswersMailer.notify_question_owner(@answer).deliver_later
        # add "format.html { normal rails stuff}"
        format.html {redirect_to question_path(@question), notice: "Thanks for answering!"}
        format.js{render :create_success}
      else
        flash[:alert] = "not saved"
        # this will render the show.html.erb inside /views/questions
        format.html{render "/questions/show"}
        format.js{render js: "alert('failure');"}
      end
    end
  end

  def destroy
     @answer.destroy
     respond_to do |format|
       format.html { redirect_to question_path(@question), notice: "Answer deleted!" }
       format.js { render }
     end
   end

  private

  def find_question
    @question = Question.find params[:question_id]
  end

  def find_and_authorize_answer
    @answer = @question.answers.find params[:id]
    redirect_to root_path unless can? :destroy, @answer
    # head will stop the http request and send a response code depending on them
    # symbol (first argument) that you pass in.
    # head :unauthorized unless can? :destroy, @answer
  end

end
