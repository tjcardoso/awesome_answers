module QuestionsAnswersHelper

  extend ActiveSupport::Concern

  def user_like
    @user_like ||= @question.like_for(current_user)
  end

  # helper_method :user_like

end
