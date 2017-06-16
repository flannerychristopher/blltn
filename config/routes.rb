Rails.application.routes.draw do

  root                      'static_pages#home'
  get     '/help',      to: 'static_pages#help'
  get     '/join',      to: 'users#new'
  post    '/join',      to: 'users#create'

  resources :users

end
