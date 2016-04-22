Rails.application.routes.draw do

  get 'welcome/index'

  get 'welcome/hello'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  #This defines a route so that wwhen we receive a GET request with url: /home
  # rails will invoke the WelcomeController with 'index' action
  get "/home" => "welcome#index"

  get "/aboot" => "welcome#aboot"


  get "/contact_us" => "contact_us#new"
  post "contact_us" => "contact_us#create"

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection   #we use this because it doesn't require an id
    # delete :destroy, on: :member
    # delete :destroy
  end

  resources :questions do
    # the answers routes will be the standard ones prefixed with /questions/:question_id
    # this way, when we want to create an answer, we know the question that it references
    # all the helpers will be the same as before, prefixed with 'question_'
    resources :votes, only: [:create, :update, :destroy]
    resources :answers, only: [:create, :destroy]

    resources :likes, only: [:create, :destroy]

  end
  #generates all the below

  # assignment from day 18:
  # get "/questions/new"        => "questions#new",     as: :new_question
  # post "/questions"           => "questions#create",  as: :questions
  # get "/questions/:id"        => "questions#show",    as: :question  #singular for show
  # get '/questions'            => "questions#index"
  # get '/questions/:id/edit'   => "questions#edit",    as: :edit_question
  # patch "/questions/:id"      => "questions#update"   #dont need anything because of questions#show
  # delete 'questions/:id'      => "questions#destroy"

  # delete "/questions/:id" => "questions#destroy"
  # get "/questions/:id/edit" => "questions#edit"
  # get "/questions/:id/" => "questions#show"

  # post "/questions/:id/comments" => "comments#create"
  # get "/faq" => "faq#new"


  # for this route we will have helper methods: about_us_path and about_us_url
  # get "/aboot" => "welcome#aboot" as: :about_us

  # this defines the 'root' or home page on our application to go to the
  # welcomecontroller with 'index' action. we will have acces to the helper
  # methods: root_path and root_url
  root "welcome#index"

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
