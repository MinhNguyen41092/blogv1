Rails.application.routes.draw do
  
  controller :pages do
    get :home
    get :about
    get :projects
  end
  
  root 'pages#home'
  
  get '/home', to: 'pages#home'
  
  resources :users, except: [:new, :destroy]
  get '/register', to: 'users#new'
  
  get '/login', to: "logins#new" #point to logins controller new action
  post '/login', to: "logins#create"
  get '/logout', to: "logins#destroy"
  
  resources :articles do
    resources :comments, except: [:index, :show]
  end
end
