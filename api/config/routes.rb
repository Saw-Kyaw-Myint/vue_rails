Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  scope '/api' do
    get 'users', to: 'users#index', as: 'api_users'
    get 'users/:id', to: 'users#show', as: 'api_user'
    post 'users', to: 'users#create'
    patch 'users/:id', to: 'users#update'
    put 'users/:id', to: 'users#update'
    delete 'users/:id', to: 'users#destroy'

    post '/auth/signup', to: 'authentication#signup'
    post '/auth/login', to: 'authentication#login'
    get '/*a', to: 'application#not_found'
  end
end
