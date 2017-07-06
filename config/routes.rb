Rails.application.routes.draw do

  root                       'static_pages#home'
  get     '/help',       to: 'static_pages#help'

  get     '/join',        to: 'users#new'
  post    '/join',        to: 'users#create'

  get     '/login',       to: 'sessions#new'
  post    '/login',       to: 'sessions#create'
  delete  '/logout',      to: 'sessions#destroy'

  get     '/boards/new',    to: 'groups#new',       as: "new_board"
  post    '/boards/create', to: 'groups#create',    as: "create_board"
  get     '/boards',        to: 'groups#index',     as: "boards"
  get     '/boards/:id',    to: 'groups#show',      as: "board"


  resources :users,         only: [:new, :create, :edit, :show]

end
