Rails.application.routes.draw do

  root to:'home#index'

  get 'home/index'

  resources :sessions, only: [:new, :create, :destroy]

  resources :users do
    resources :bookmarks
  end

  resources :reviews do
    resources :comments
  end
  
  get 'account', to: 'account#edit'

  patch 'account', to: 'account#update'

  get 'account/reviews'

  get 'about', to:'about#me'

  get 'login', to:'sessions#new'

  get 'signup', to:'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
