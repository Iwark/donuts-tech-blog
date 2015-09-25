Rails.application.routes.draw do

  root 'articles#index'
  get '/health' => 'application#health'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # 記事
  resources :articles, only: [:index, :show] do 
    member do 
      delete :destroy_tag
    end
  end
  resources :article_images, only: [:create] do
    collection do
      post :upload
    end
  end
  resources :series, only: [:show]
  resources :tags,   only: [:show]
  resources :users,  only: [:show]

  ##############
  #  ログイン必須
  namespace :users, path: '' do
    resources :articles, path: :my_articles, except: [:show]
  end

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
    resources :tags,   except: [:show, :destroy]
    resources :users,  except: [:show, :destroy]
  end

end
