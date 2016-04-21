class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_create, only: :create
  before_action :authorize_destroy, only: :destroy

  def create
    like          = Like.new
    like.user     = current_user
    like.question = question
    if like.save
      redirect_to question, notice: "Liked!"
    else
      redirect_to question, alert: "You're already liked!"
    end
  end

  def destroy
    like.destroy
    redirect_to question_path(like.question_id), notice: "Un-liked!"
  end

  private

  def authorize_create
    redirect_to question, notice: "Can't like!" unless can? :like, question
  end

  def authorize_destroy
    redirect_to question, notice: "Can't remove like!" unless can? :destroy, like
  end

  def question
    @question ||= Question.find params[:question_id]
  end

  def like
    @like ||= Like.find params[:id]
  end
end
