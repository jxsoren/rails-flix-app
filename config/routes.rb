Rails.application.routes.draw do
  root "flicks#index"

  resources :genres
  resources :users

  get "/signup" => "users#new"

  get "/flicks/filter/:filter" => "flicks#index", as: :filtered_flicks

  resources :flicks do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  resource :genres

  get "/signin" => "sessions#new"
  resource :session, only: [:new, :create, :destroy]

end
