Rails.application.routes.draw do

  root                      'static_pages#home'
  get     '/help',      to: 'static_pages#help'

  get     '/join',      to: 'users#new'
  post    '/join',      to: 'users#create'

  get     '/login',     to: 'sessions#new'
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: 'sessions#destroy'

  resources :users,     only: [:new, :create, :edit, :show]
  resources :boards

end
