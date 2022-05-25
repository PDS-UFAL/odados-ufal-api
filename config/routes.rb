Rails.application.routes.draw do
  require 'sidekiq/web'

  scope 'api' do
    post 'login', to: 'authentications#login'
    get '/forms/:id/form_sends', to: 'forms#form_sends'
    get '/forms/:id/table', to: 'forms#table'
    post '/forms/response_history', to: 'forms#response_history'
    
    resources :users do
      get 'me', to: 'users#me', on: :collection
      post 'forgot_password', to: 'users#forgot_password', on: :collection
      put 'reset_password', to: 'users#reset_password', on: :collection
    end

    resources :forms
    resources :form_sends
    resources :sectors
    resources :responses, only: [:create] do
      get 'forms/:form_send_id', to: 'responses#answers', on: :collection
    end

    mount Sidekiq::Web => '/sidekiq'
  end
end
