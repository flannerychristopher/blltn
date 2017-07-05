Rails.application.routes.draw do

  root                       'static_pages#home'
  get     '/help',       to: 'static_pages#help'

  get     '/join',        to: 'users#new'
  post    '/join',        to: 'users#create'

  get     '/login',       to: 'sessions#new'
  post    '/login',       to: 'sessions#create'
  delete  '/logout',      to: 'sessions#destroy'

  # get     '/boards',      to: 'groups#index'
  # get     '/boards/:id',   to: 'groups#show'
  get     '/boards',       to: 'groups#index',     as: "boards"
  get     '/boards/:id',   to: 'groups#show',      as: "board"

  resources :users
  # resources :groups,    only: [:index, :new, :create, :show]

end
