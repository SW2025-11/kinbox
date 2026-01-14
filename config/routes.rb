Rails.application.routes.draw do
  get "favorites/index"
  root "illusts#index"

  # 認証
  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get  "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  # イラスト
  resources :illusts do
    member do
      get  :download
      post :favorite
    end
  end

  # お気に入り一覧
  resources :favorites, only: [:index]
end
