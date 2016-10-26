Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'items#index'
  get '/items' => 'items#index', as: :items
  get '/items/new' => 'items#new', as: :new_item
  get '/items' => 'items#create'
  # get '/items/:id' => 'items#show', as: :item
end
