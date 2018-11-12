# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  resources :orders
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
    end
  post '/graphql', to: 'graphql#execute'
  resources :books do
    resources :titles
    resources :cover_arts
    resources :synopses do
      member do
        post :vote
      end
    end
  end

  scope '/books/:book_id/chapters/:chapter' do
    resources :chapters, path: '/' do
      resources :edits
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  resources :token, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
