class Ability
  include CanCan::Ability

  # CanCanCan automaticlaly integrates with ApplicationController and it assumes
  # you have a method in your ApplicationController called "current_user"
  # you don't have to automatically create an ability object(automaticlay done)
  # you just need to learn how to write authorization rules and how to use them

  def initialize(user)

    # we instantiate the user to User.new to avoid having the user be nil if
    # the user is not signed in. We assume here that 'user' will be "User.new"
    # if the user is not signed in.
    user ||= User.new

    # in terminal, you can manuall set a user to admin by typing in bin/rails c
    # u = User.find(???)
    # u.update(admin: true)

    # this gives superpowers to the admin user by having the ability to manage
    # everything (all actions on all models)
    # no need to make alias for :manage
    can :manage, :all if user.admin?


    alias_action :create, :read, :update, :destroy, :to => :crud
    # define the ability to :manage (do annything) with a question
    # in the case below, we put inside the block an expresion that will return
    # true or false. This will determine whether the user is allowed ot manage
    # a question or not

    can :crud, Question do |q|
      q.user == user && user.persisted?
    end

    can :crud, Answer do |a|
      (a.question.user == user || a.user == user) && user.persisted?

    end

    can :like, Question do |q|
      # user can't like their own questions
      q.user != user
    end

    can :destroy, Like do |l|
      l.user == user
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
