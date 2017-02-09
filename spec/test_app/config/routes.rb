Rails.application.routes.draw do
  mount SolidusLiquid::Engine => "/solidus_liquid"
  get 'pages/:id', to: 'pages#show', as: :page
end
