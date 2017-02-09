SolidusLiquid::Engine.routes.draw do
  root to: 'home#index'
  get 'pages/:id', to: 'pages#show', as: :page
end
