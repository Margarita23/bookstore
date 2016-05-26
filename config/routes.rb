Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => {:registrations => "user/registrations"} do
    get "/signup"   => "registrations#new",   :as => :new_user_registration
    end

  #resources :ratings
  
  resources :carts do
    resources :line_items
  end
  resources :orders 
  resources :categories
  resources :books
  resources :address
  
  root 'home#bestsellers'
  
  get 'home/shop' => 'home#shop' , as: 'shopping'
  
  get 'ratings' => 'ratings#index', as: 'ratings'
  post 'ratings' => 'ratings#create' 
  get 'book/:id/ratings/new' => 'ratings#new', as: 'new_rating'
  get 'book/:id/rating/:id' => 'ratings#show', as: 'rating'
  get 'book/:id/rating/:id/edit' => 'ratings#edit', as: 'edit_rating'
  
  post 'cart/:id' => 'carts#empty_cart', as: 'empty_cart', method: :post

  resources :checkout
  
  get 'checkout/new' => 'checkout#to_address', as: 'to_address', method: :get
  
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
