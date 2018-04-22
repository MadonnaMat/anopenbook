# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  resources :orders
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
    end
  post '/graphql', to: 'graphql#execute'
  resources :books

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  resources :edits
  resources :titles
  resources :cover_arts
  resources :chapters
  resources :synopses
  resources :token, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
