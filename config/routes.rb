SolidusLiquid::Engine.routes.draw do
  root to: 'home#index'
  get 'pages/:id', to: 'pages#show', as: :page
end

Spree::Core::Engine.routes.draw do
  if (
    Spree::Auth::Engine.frontend_available? &&
    Spree::Auth::Config.draw_frontend_routes
  )
    devise_scope :spree_user do
      get '/account/logout', to: 'user_sessions#destroy'
    end
  end
end
