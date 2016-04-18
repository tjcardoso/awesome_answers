class Answer < ActiveRecord::Base
  # by having this 'belongs_to' in the model, we can easily fetch
  # the question for a given answer by running:
  # ans = Answer.find(14)
  # q = ans.question
  # belongs_to assume that the 'asnwers' table has a foregin_key
  # called question_id which is Rails Convention
  belongs_to :user
  belongs_to :question

  validates :body, presence: true

  def user_full_name
    user ? user.full_name : ""
  end
  

end
