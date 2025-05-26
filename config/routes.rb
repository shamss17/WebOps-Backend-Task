Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  
post '/signup' , to: 'users#create'

post '/login' , to: 'sessions#create'

get '/auth_test', to: 'auth_test#index'

resources :posts do
  resources :comments, only: [:create]
end

resources :comments, only: [:update, :destroy]
end
