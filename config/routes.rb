Rails.application.routes.draw do
  require 'sidekiq/web'

  scope 'api' do
    post 'login', to: 'authentications#login'
    
    resources :users do
      get 'me', to: 'users#me', on: :collection
      post 'forgot_password', to: 'users#forgot_password', on: :collection
      put 'reset_password', to: 'users#reset_password', on: :collection
    end

    resources :forms
    resources :sectors
    resources :responses, only: [:create] do
      get 'forms/:form_id', to: 'responses#answers', on: :collection
    end

    mount Sidekiq::Web => '/sidekiq'
  end
end
