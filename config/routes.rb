Rails.application.routes.draw do
  get 'users/new'

  get 'cats/search'
  root 'tweets#search'
  get 'tweets/search'
  get 'images/index'
  resources 'users'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
