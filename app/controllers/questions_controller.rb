class QuestionsController < ApplicationController

  # Defining a method as a 'before_action' will make is so that rails executse
  # that method before executing the action. This is still within the request
  # cycle
  # You can give the "before_action" method two options:  :only or :exception
  # This will help you limit the action which the "find_question" method will
  # be executed before
  # in the code below 'find_question' will only be executed before: show, edit
  # update and destroy actions

  before_action :authenticate_user!, except: [:index, :show]  #should happen first

  # remove :edit from before_action find_question
  # before_action(:find_question, {only: [:show, :update, :destroy]})

  before_action :find_question, only: [:edit, :update, :destroy, :show]
  before_action :authorize_question, only: [:edit, :update, :destroy]

  skip_before_action :authorize_question

  include QuestionsAnswersHelper
  helper_method :user_like

  def new
    # we need to define a new 'Question' object in order to be able to
    # properly generate form in Rails

    @question = Question.new
  end

  def create
    #Method 1
    # @question = Question.new
    # @question.title = params[:question][:title]
    # @question.body = params[:question][:body]
    # @question.save!
    # render text: params


    #method 2
    # @question = Question.create({title: params[:question][:title],
                                # body: params[:question][:body]})

    #method 3
    # @question = Question.create(params[:question])
    # this will throw a error:  ACtiveModel::ForbiddenAttributesError exception

    # Method 4  (main type)
    # we use strong parameters feature of Rails
    @question = Question.new(question_params)

    @question.user = current_user


    if @question.save
      flash[:notice] = "Question Created!"
      # redirect_to question_path({id: @question.id})
      redirect_to question_path(@question)

    else
      flash[:alert] = "Question didn't save"
      # this will render '/app/views/questions/new.html.erb' becasue the default
      # in this action is to render 'app/views/questions/create.html.erb'
      render :new

    end

  end

  # we receive a request: GET /questions/56
  # params[:id] will be '56'
  def show
    @answer = Answer.new
    respond_to do |format|
      format.html {render} # render questions/show.html.erb
      format.json {render json: @question.to_json}
      format.xml {render xml: @question.to_xml}
    end
  end

  def index
    # @questions = Question.all
    @questions = Question.page(params[:page]).per(10)
    respond_to do |format|
      format.html {render}
      format.json {render json: @questions.select(:id, :title, :view_count) }
    end
  end


  def edit
  end

  def update
    @question.slug = nil
    if @question.update question_params
      # flash messages can be set either direclty use: flash[:notice] = ".."
      # you can also pass ':notice' or ':alert 'options to the 'redirect_to'
      # method
      redirect_to question_path(@question), notice: "Question #{@question.title} updated!"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path

  end

  private


  # def user_like
  #   @user_like ||= @question.like_for(current_user)
  # end
  # helper_method :user_like

  def authorize_question
    redirect_to root_path unless can? :crud, @question
  end

  def find_question
    @question = Question.friendly.find params[:id]
  end

  def question_params
    params.require(:question).permit([:title, :body,
                                      :category_id, {tag_ids: [] }])
  end


end
