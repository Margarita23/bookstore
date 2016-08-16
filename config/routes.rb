Rails.application.routes.draw do
  
  post '/rate' => 'rater#create', :as => 'rate'
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations"} do
    get "/signup" => "registrations#new",   :as => :new_user_registration
  end
  
  resources :carts, only: [:show, :destroy]
  resources :line_items, only: [:create, :destroy]
  resources :orders, only: [:show, :index, :new_order]
  resources :categories, only: [:show]
  resources :coupons, only: [:update]
  resources :books, only: [:show] do
    resources :ratings, only: [:new, :show, :create]
  end
  
  put 'carts/:id/update_items' => "carts#update_items", as: 'update_carts_items'
  
  resources :address, only: [:update]
  
  root 'home#bestsellers'
  
  get 'home/shop' => 'home#shop' , as: 'shopping'
  
  get 'author/:id' => 'authors#show', as: 'author', method: :get
  
  get 'new_order/:id' => 'orders#new_order', as: 'new_order_show', method: :get
    
  resources :checkouts, only: [:show, :create]
  
  get '/:locale' => 'application#change_language', as: 'change_language'
end
