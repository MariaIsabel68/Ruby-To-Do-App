Rails.application.routes.draw do
  #get 'home/index'
  devise_for :users

  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  resources :todo_lists do 
    resources :todo_items
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
 root 'home#index'
end
