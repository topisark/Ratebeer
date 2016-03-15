Ratebeer::Application.routes.draw do

  resources :beers, defaults: {format: :json}
  resources :sessions, only: [:new, :create]

  root 'application#index'
  get '*path' => 'application#index'

end
