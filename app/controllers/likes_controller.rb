class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_create, only: :create
  before_action :authorize_destroy, only: :destroy
  before_action :question # this will call 'question' method to force
                          # finding question as we will need it for both
                          # the create and destory actions
  def create
    like          = Like.new
    like.user     = current_user
    like.question = question
    respond_to do |format|
      if like.save
        format.html {redirect_to question, notice: "Liked!"}
        format.js {render }
      else
        format.html {redirect_to question, alert: "You're already liked!"}
        format.js {render js: "alert('Cant like, please refresh the page!')"}
      end
    end

  end

  def destroy
    like.destroy

    respond_to do |format|
      format.html {redirect_to question_path(like.question_id), notice: "Un-liked!"}
      format.js {render }

    end
  end

  private

  def authorize_create
    redirect_to question, notice: "Can't like!" unless can? :like, question
  end

  def authorize_destroy
    redirect_to question, notice: "Can't remove like!" unless can? :destroy, like
  end

  def question
    @question ||= Question.friendly.find params[:question_id]
  end

  def like
    @like ||= Like.find params[:id]
  end
end
