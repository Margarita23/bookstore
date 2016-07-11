Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations"} do
    get "/signup" => "registrations#new",   :as => :new_user_registration
  end
  
  resources :carts, only: [:show, :destroy] do
    resources :line_items, only: [:update, :create, :destroy]
  end
  resources :orders#, only: [:show, :index]
  resources :categories, only: [:show]
  resources :books, only: [:show] do
    resources :ratings, only: [:new, :show, :create]
  end
  resources :address, only: [:update]
  
  root 'home#bestsellers'
  
  get 'home/shop' => 'home#shop' , as: 'shopping'
  
  #get '/complete/order/:order_id' => 'checkout#complete', as: 'complete_order', method: :get
  
  get 'author/:id' => 'authors#show', as: 'author', method: :get
  
  get 'new_order/:id' => 'orders#new_order', as: 'new_order_show', method: :get
  
  resources :checkouts#, only: [:new, :update]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
