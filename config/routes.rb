Rails.application.routes.draw do

  root to:'home#index'

  get 'home/index'

  resources :users do
    resources :bookmarks
  end

  resources :reviews do
    resources :comments
  end

  get 'account/reviews'

  get 'about', to:'about#me'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
