Rails.application.routes.draw do
  scope 'api' do
    post 'login', to: 'authentications#login'
    
    resources :users do 
      get 'me', to: 'users#me', on: :collection
    end

    resources :forms
    resources :sectors
    resources :responses, only: [:create]
  end
end
