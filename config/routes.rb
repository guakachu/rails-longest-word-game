Rails.application.routes.draw do
  root to: 'games#new'
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
