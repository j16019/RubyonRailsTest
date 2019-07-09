Rails.application.routes.draw do

  ## get 'home/top'
  get "/" => "home#top"
  get "post/index" => "post#index"
  post "post/create" => "post#create"

  get "show" => "home#show"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
