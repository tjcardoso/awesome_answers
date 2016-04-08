class QuestionsController < ApplicationController

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
    question_params = params.require(:question).permit([:title, :body])
    @question = Question.new(question_params)

    if @question.save
      # redirect_to question_path({id: @question.id})
      redirect_to question_path(@question)

    else
      # this will render '/app/views/questions/new.html.erb' becasue the default
      # in this action is to render 'app/views/questions/create.html.erb'
      render :new

    end

  end

  # we receive a request: GET /questions/56
  # params[:id] will be '56'
  def show
    @question = Question.find params[:id]
  end

  def index
    @questions = Question.all
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
    question_params = params.require(:question).permit(:title, :body)
    if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  


end
