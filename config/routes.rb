Rails.application.routes.draw do
  devise_for :users
   resources :tasks do
  collection do
    get 'search'
  end
end
  root 'tasks#index'
  get 'home/about'
 

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
