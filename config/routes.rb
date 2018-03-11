Rails.application.routes.draw do
  get 'cats/search'
  root 'tweets#search'
  get 'tweets/search'
  get 'images/index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
