class Question < ActiveRecord::Base
  #when using 'has_many' you must put the symbol for the associated
  # record in plural format
  # you also should provide the :dependent option which can be ehter:
  # :destroy    which deletes all the answers when question is deleted
  # :nullify     which makes question_id NULL for all associated answers
  belongs_to :category
  belongs_to :user
  has_many :answers, dependent: :destroy

  has_many :liking_users, through: :likes, source: :user
  has_many :likes, dependent: :destroy

  has_many :voting_users, through: :votes, source: :user
  has_many :votes, dependent: :destroy

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})
  # validates(:title, {presence: true, uniqueness: true})    #can also do
  # validates :title, presence: true, uniqueness: {message: "must be unique!"}   #can also do

  validates :body, length: {minimum: 5}

  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  # how to implement REGEX statememts:
  # VALID_EMAIL_REGEX = /\A([\w+\]
  # validates: :email, format: VALID_EMAIL_REGEX

  #this validates that the combination of the title and the body must be unique
  # it means that title by itself doesnt have to be unique and body by itself
  # doesn't have to be unique
  validates :title, uniqueness: {scope: :body}

  #we use  'validate' is for custom validation
  validate :no_monkey

  # this will call the "set_defaults" method right after the initialize method
  after_initialize :set_defaults

  before_validation :titleize_title

  # scope :recent_three, lambda {order("created_at DESC").limit(3) }
  # same as below

  def self.recent_three
    order("created_at DESC").limit(3)
  end


  def self.search_term(words)
    where(["title ILIKE ? OR body ILIKE ? OR email ILIKE ?", "%#{words}%", "%#{words}%", "%#{words}%"])
  end

  # Question.search("hello")

  def self.search(words)
    # where("title ILIKE '%#{words}%' OR body ILIKE '%#{words}%')
    where(["title ILIKE ? OR body ILIKE ?", "%#{words}%", "%#{words}%"])
    # where(["title ILIKE :term OR body ILIKE :term", {term:  "%#{words}%"}])
  end

  def user_full_name
    user ? user.full_name : ""
  end

  def like_for(user)
    likes.find_by_user_id user if user
  end

  def vote_for(user)
    votes.find_by_user_id user if user
  end

  def vote_value
    votes.up_count - votes.down_count
  end

  private

  def titleize_title
    self.title = title.titleize
  end

  def set_defaults
    self.view_count ||= 0
  end

  def no_monkey
    if title.present? && title.downcase.include?("monkey")
      errors.add(:title, "No Monkeys!")
    end
  end



end

# reload!
# q.save
# q.errors   will show "must be unique!"
