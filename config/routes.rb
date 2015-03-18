Rails.application.routes.draw do

  root 'articles#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :articles

end
