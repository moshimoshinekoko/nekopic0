Rails.application.routes.draw do
  root 'cats#index'
  get 'cats/twitterserch'
  get 'tweets/index'
  get 'tweets/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
