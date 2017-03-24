# rubocop:disable Metrics/BlockLength
Solidify::Engine.routes.draw do
  root to: 'home#index'
  get 'pages/:id', to: 'pages#show', as: :page
  get 'account/addresses', to: 'addresses#index', as: :customer_addresses

  devise_for :customers,
             path: 'account',
             class_name: 'Spree::User',
             # module: :devise,
             path_names: {
               registration: 'register',
               sign_up: '',
               sign_in: 'login',
               sign_out: 'logout',
               password: 'recover',
               confirmation: 'verification',
               edit: ''
             },
             controllers: {
               registrations: 'solidify/registrations',
               sessions: 'solidify/sessions'
             }

  devise_scope :customer do
    get 'account/login', to: 'sessions#new'
    post 'account/login', to: 'sessions#create'
    get 'account/logout', to: 'sessions#destroy'
    get 'account/signup', to: 'registrations#new'
    post 'account/signup', to: 'registrations#create'
    get 'account/password/recover', to: 'passwords#new'
    post 'account/password/recover', to: 'passwords#create'
    get 'account/password/change', to: 'passwords#edit'
    put 'account/password/change', to: 'passwords#update'
    get 'account/register', to: 'registrations#new'
    post 'account/register', to: 'registrations#create'
  end

  get '/account', to: 'customers#show', as: :customer
  get '/collections/:id', to: 'collections#show', as: :taxon
  get '/search', to: 'search#index', as: :search

  get '/collections/:collection_id/products/:id?variant=:variant_id',
      to: 'products#show'
  get '/collections/:collection_id/products/:id', to: 'products#show'
  get '/products/:id?variant=:variant_id', to: 'products#show', as: :variant
  get '/products/:id', to: 'products#show', as: :product

  post '/cart/add', to: 'orders#populate'
  get '/cart', to: 'carts#show', as: :cart
end
