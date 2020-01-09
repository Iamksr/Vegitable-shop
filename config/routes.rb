Rails.application.routes.draw do
  resources :places
  # resources :rating_reviews
  devise_for :users
  resources :addresses
  resources :cart_items
  resources :carts
  resources :charges
  resources :categories
  resources :rating_reviews

  get 'products/user/:id' => "products#user_product"

  root 'welcome#about'
  # resources :orders
  resources :products do
  	 get "/cart" => "products#add_to_cart"
     get "/wishlist", action: :add_wishlist, as: :add_wishlist
  end
  get 'category/:id/' => "categories#show"
  get '/cart' => "products#cart"
  get 'welcome/index'

 namespace :admin, module: nil  do
    root "admin#index"
    resources :users

  end
    post '/admin/users/:id/edit' => "users#edit"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 get '/wishlist' => "products#wishlist"
  post '/add_to_cart/:product_id' => 'carts#add_to_cart', :as => 'add_to_cart'
  
  #=========== Charges ==============
  get 'charges/new' => "charges#new"

  post 'charges/create' => 'charges#create'
   # resources :carts
   # resources :products
   # resources :cart_items
   # ===========    User Profile =============
  get 'user_profile' => "orders#user_profile" 
  #  ===========  Order Details  =============
  post 'orders' => "orders#all_order_show"
  get 'orders' => "orders#index"

  # resources :orders do
  #   member do
  #     get 'order_pdf'
  #   end
  # end 
# get 'products_all' => "products#all_product"
get '/product/:id' => "products#show"
   get 'order_pdf' => 'orders#order_pdf'
  # # =========  Order Review  ===================
   get 'order_review/:id' => 'orders#order_review'
  get 'user_profile' => "orders#user_profile" 
  #  ===========  Order Details  =============
  post 'orders' => "orders#all_order_show"
  get 'orders' => "orders#index"


  # ============ Oder delivery report ===========
  get 'order_delivery_report' => 'orders#order_delivery_report'

 get 'about' => 'welcome#about'
 get 'contact' => 'welcome#contact'

   root :to => 'products#show'
    get "/update_cart_item_quantity/:type/:cart_item_id" => "carts#update_cart_item_quantity", as: :update_cart_item_quantity
   delete 'remove_wishlist_item/:id' => "products#remove_wishlist", as: :remove_wishlist
   delete 'remove_cart_item/:id' => "products#remove_cart", as: :remove_cart


 post 'order' => "orders#all_order_show"
  get 'orders_history' => "orders#index"
end
