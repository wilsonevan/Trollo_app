Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/new'

  # get "tasks_form", to: "tasks#form"
  
  root "boards#index"
  

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :boards do 
    resources :lists
  end
  
  resources :lists do
    resources :tasks
  end
end
