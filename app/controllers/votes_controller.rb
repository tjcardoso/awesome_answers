class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    vote         = Vote.new(is_up:  params[:vote][:is_up],
                            question: question,
                            user: current_user)
    if vote.save
      redirect_to question, notice: "Voted!"
    else
      redirect_to question, notice: "You already voted!"
    end
  end

  def update
    
    if vote.update(is_up: params[:vote][:is_up])
      redirect_to question, notice: "Vote Changed"
    else
      redirect_to question, alert: "Vote wasn't changed"
    end
  end

  def destroy

    vote.destroy
    # redirect_to question_path(question), notice: "vote undone!" #also works
    redirect_to question, notice: "Vote undone!"

  end

  private

  def vote
    @vote ||= current_user.votes.find params[:id]
  end
  def question
    @question ||= Question.friendly.find params[:question_id]
  end

end
