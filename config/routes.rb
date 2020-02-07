Rails.application.routes.draw do
  resources :users, param: :_email, only: [:create]
  resources :favourites, only: [:index, :create, :destroy]
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
