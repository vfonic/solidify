SolidusLiquid::Engine.routes.draw do
  root to: 'home#index'
  get 'pages/:id', to: 'pages#show', as: :page

  if (
    Spree::Auth::Engine.frontend_available? &&
    Spree::Auth::Config.draw_frontend_routes
  )

    devise_for :spree_user, {
      class_name: 'Spree::User',
      controllers: {
        sessions: 'spree/sessions',
        registrations: 'spree/registrations',
        passwords: 'spree/passwords',
        confirmations: 'spree/confirmations'
      },
      skip: [:unlocks, :omniauth_callbacks],
      path_names: { sign_out: 'logout' },
      path_prefix: :user
    }

    resources :users, only: [:edit, :update]

    devise_scope :spree_user do
      get 'account/login', to: 'sessions#new', as: :login
      post 'account/login', to: 'sessions#create', as: :create_new_session
      get 'account/logout', to: 'sessions#destroy', as: :logout
      get 'account/signup', to: 'registrations#new', as: :signup
      post 'account/signup', to: 'registrations#create', as: :registration
      get 'account/password/recover', to: 'passwords#new', as: :recover_password
      post 'account/password/recover', to: 'passwords#create', as: :reset_password
      get 'account/password/change', to: 'passwords#edit', as: :edit_password
      put 'account/password/change', to: 'passwords#update', as: :update_password
      get 'account/confirm', to: 'confirmations#show', as: :confirmation if Spree::Auth::Config[:confirmable]
    end

    get '/checkout/registration', to: 'checkout#registration', as: :checkout_registration
    put '/checkout/registration', to: 'checkout#update_registration', as: :update_checkout_registration

    resource :account, controller: 'users'
  end

  if (
    Spree::Auth::Engine.backend_available? &&
    Spree::Auth::Config.draw_backend_routes
  )

    namespace :admin do
      devise_for(:spree_user, {
        class_name: 'Spree::User',
        controllers: {
          sessions: 'spree/admin/sessions',
          passwords: 'spree/admin/passwords'
        },
        skip: [:unlocks, :omniauth_callbacks, :registrations],
        path_names: { sign_out: 'logout' },
        path_prefix: :user
      })

      devise_scope :spree_user do
        get '/authorization_failure', to: 'sessions#authorization_failure', as: :unauthorized
        get '/login', to: 'sessions#new', as: :login
        post '/login', to: 'sessions#create', as: :create_new_session
        get '/logout', to: 'sessions#destroy', as: :logout
      end
    end
  end

  mount Spree::Core::Engine, at: '/'
end
