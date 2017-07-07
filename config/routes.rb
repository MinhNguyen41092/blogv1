Rails.application.routes.draw do
  require "api_constraints.rb"

  controller :pages do
    get :home
    get :about
    get :projects
  end

  root "pages#home"

  get "/home", to: "pages#home"

  resources :users, except: [:new, :destroy]
  get "/register", to: "users#new"

  get "/login", to: "logins#new" #point to logins controller new action
  post "/login", to: "logins#create"
  get "/logout", to: "logins#destroy"

  resources :articles do
    resources :comments, except: [:index, :show]
  end

  namespace :api, defaults: {format: :json},
    constraints: { subdomain: "api" }, path: "/" do

    namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :articles, only: [:show, :index, :create, :update]
    end
  end
end
