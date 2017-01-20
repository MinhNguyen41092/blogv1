Rails.application.routes.draw do
  root 'pages#home'
  get '/home', to: 'pages#home'
  
  resources :users, except: [:new, :destroy]
  get '/register', to: 'users#new'
  
  get '/login', to: "logins#new" #point to logins controller new action
  post '/login', to: "logins#create"
  get '/logout', to: "logins#destroy"
  
  resources :articles
  
  resources :comments
end
