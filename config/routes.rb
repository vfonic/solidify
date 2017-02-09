SolidusLiquid::Engine.routes.draw do
  get 'pages/:id', to: 'pages#show', as: :page
end
