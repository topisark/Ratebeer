Ratebeer::Application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries

  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  get 'ratings', to: 'ratings#index'
  get 'exercises', to: 'exercises#index'
  get 'exercises/exercise1', to: 'exercises#exercise1'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  get 'places', to: 'places#index'
  post 'places', to:'places#search'
  get 'beerlist', to:'beers#list'
  get 'ngbeerlist', to:'beers#nglist'

  resources :sessions, only: [:new, :create]
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :places, only:[:index, :show]

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  resources :memberships do
    post 'toggle_membership', on: :member
  end

end
