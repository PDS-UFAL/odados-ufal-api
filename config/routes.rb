Rails.application.routes.draw do
  resources :forms
  resources :users do 
    get '/me', to: 'users#me', on: :collection
  end
  resources :sectors
  resources :forms
  post '/login', to: 'auth#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
