InfiniteBuyer::Application.routes.draw do

  #constraints(CheckSubdomain) do
    
  #end
  
  devise_for :super_admins

  get 'misc/index'

  devise_for :users, :path => 'members', :controllers => {
    :registrations => 'registrations',
    :passwords => 'passwords',
    :omniauth_callbacks => 'users/omniauth_callbacks'}

  devise_for :admins, :controllers => {:registrations => 'admins/registrations',
    :sessions => 'admins/sessions',
    :confirmations => 'admins/confirmations',
    :un_locks => 'admins/unlocks',
    :passwords => 'admins/passwords'}

  devise_for :super_admins, :controllers => {:registrations => 'super_admins/registrations',
    :sessions => 'super_admins/sessions',
    :confirmations => 'super_admins/confirmations',
    :un_locks => 'super_admins/unlocks',
    :passwords => 'super_admins/passwords'}
  namespace :super_admins do
    resources :offers do
      collection do
        get 'search'
        post 'search'
      end
    end
  end

  match '/admin' => 'admin#index', :as => :admin_root
  match '/super_admin' => 'super_admins/home#index', :as => :super_admin_root
  match '/admin-activity' => 'admin#admin_activity', :as => :admin_activity

  resources :users, :only => [:update] do
    resource :account, :only => [:new, :create, :edit, :update]
    collection do
      get 'seller'
      get 'buyer'
    end
  end

  devise_scope :user do
    get 'new_registration' => 'registrations#new_registration'
    put 'create_registration' => 'registrations#create_registration'
  end

  get 'seller' => 'users#seller'
  get 'sellers' => 'users#seller'
  
  match '/temp-store-offer' => 'home#temp_store_offer', :as => :temp_store_offer
  match '/init-store-offer' => 'offers#temp_store_offer', :as => :init_store_offer
  match 'offers/splash-page' => 'offers#splash_page', :as => :splash_page_offer
  match 'extend-offer' => 'offers#extend_offer', :as => :extend_offer
  match 'open-offers' => 'offers#my_open_offers', :as => :open_offers
  match 'other-offers' => 'offers#my_other_offers', :as => :other_offers
  match 'skip' => 'home#skip', :as => :skip

  # Seller my offers
  match 'my-offers' => 'bids#myoffers', :as => :my_offers

  #Accepted offers
  match 'accepted-offers' => 'bids#seller_accepted_offers', :as => :accepted_offers
  match 'counter-offers' => 'bids#seller_counter_offers', :as => :counter_offers

  #Product Details
  match 'bids/:bid_id/product-details' => 'bids#product_details', :as => :product_details

  #Service Details
  match 'bids/:bid_id/service-details' => 'bids#service_details', :as => :service_details

  #seller category
  match 'seller-category' => 'bids#seller_category', :as => :seller_category

  # Decline offer path
  match 'declined-offers' => 'offers#my_declined_offers', :as => :declined_offers

  #Admin offers
  match 'current-admin-offers' => 'admin#current_admin_offers', :as => :current_admin_offers
  match 'history-admin-offers' => 'admin#history_admin_offers', :as => :history_admin_offers

  match 'seller-search' => 'admin#seller_search', :as => :seller_search

  #send_offers_to_sellers
  match 'send-offers' => 'admin#send_offers_to_sellers', :as => :send_offers

  match 'category-list' => 'inventory#category_list', :as => :category_list
  match 'admin-category-list' => 'admin#admin_category_list', :as => :admin_category_list
  match 'sub-category' => 'inventory#create_sub_category', :as => :create_sub_category
  match 'category-subtree' => 'inventory#display_category_subtree', :as => :display_category_subtree
  match 'assign_category_keywords' => 'inventory#assign_category_and_keywords', :as => :assign_category_and_keywords
  match 'category-keyword-store' => 'admin#category_keyword_store', :as => :category_keyword_store

  #Myaccount
  match 'edit-buyer' => 'accounts#edit_buyer', :as => :edit_buyer
  match 'edit-seller' => 'accounts#edit_seller', :as => :edit_seller

  match 'update-buyer' => 'accounts#update_buyer', :as => :update_buyer
  match 'update-seller' => 'accounts#update_seller', :as => :update_seller
  match 'my-account' => 'accounts#my_account', :as => :my_account

  # New SERVICE BID
  match 'offers/:offer_id/bids/new-service' => 'bids#new_service', :as => :new_service
  # Create SERVICE BID
  match 'offers/:offer_id/bids/create-service' => 'bids#create_service', :as => :create_service

  #Get Keywords based on category
  match 'get-category-keyword' => 'inventory#get_category_keyword', :as => :get_category_keyword
  match 'set-category-keyword' => 'inventory#set_category_keyword', :as => :set_category_keyword

  #Privacy Policy
  match 'privacy-policy' => 'home#privacy_policy', :as => :privacy_policy

  # Terms of Use
  match 'terms-of-use' => 'home#terms_of_use', :as => :terms_of_use

  # How it works
  match 'how-it-works' => 'home#how_it_works', :as => :how_it_works

  # How it works - BUYER
  match 'how-it-works-buyer' => 'home#how_it_works_buyer', :as => :how_it_works_buyer

  # How it works - SELLER
  match 'how-it-works-seller' => 'home#how_it_works_seller', :as => :how_it_works_seller

  # Faqs
  match 'faqs' => 'home#faqs', :as => :faqs

  # Examples
  match 'example' => 'home#example', :as => :example

  # Company Info
  match 'company-info' => 'home#company_info', :as => :company_info

  # Facebook Comments (Raves)
  match 'raves' => 'home#raves', :as => :raves

  # New
  match 'news' => 'home#news', :as => :news

  # Contact Us
  match 'contact-us' => 'home#contact_us', :as => :contact_us

  # Support
  match 'support' => 'home#support', :as => :support

  # Blog
  namespace :blog do
    resources :posts do
      member do
        get :deactivate
        get :activate
      end
      collection do
        get :list
      end
    end
    resources :comments, :except => :create
  end


  namespace :admins do
    resources :offers, :only => [] do
      member do
        get 'comments'
      end
    end
  end

  resources :offers, :except => [:new]  do
    member do
      get 'decline'
    end
    resources :bids, :only => [:new, :create, :index]
  end

  resources :purchases, :only => [] do
    member do
      get 'buy'
    end
    collection do
      post 'ipn_notification'
    end
  end

  namespace :api do
    namespace :v1 do
      match 'tokens/:provider/:id' => 'tokens#create', :via => :post
      match 'tokens/:token' => 'tokens#destroy', :via => :delete
    end
  end

  get 'home/terms_of_use_popup'
  get 'home/reset_logged_in_as_session'
  get 'home/wym_iframe'

  # Blog
  constraints(BlogSubdomain) do
    match '/' => 'blog/posts#index'
    #match 'sitemap' => 'blog/sitemap#show'
    namespace :blog do
      resources :posts
      resources :comments, :only => :create
    end
    match '/:id' => 'blog/posts#show'
  end


  root :to => 'home#new_offer'
end
