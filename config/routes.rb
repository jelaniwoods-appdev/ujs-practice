Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    patch "move", on: :member
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
