Rails.application.routes.draw do

  root                      'static_pages#home'
  get     '/help',      to: 'static_pages#help'
  get     '/join',      to: 'users#new'

  resources :users

end
