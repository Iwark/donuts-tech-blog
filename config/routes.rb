Rails.application.routes.draw do

  root 'articles#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :articles

  ##############
  #  管理画面
  resources :admin, only: [:index]
  namespace :admin do
    resources :articles, only: [:index] do
      member do 
        patch 'approve'
      end
    end
    resources :series, except: [:show, :destroy]
  end

end
