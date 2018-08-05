Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :organizations do
    resources :dogs
  end

  resources :dogs, only: [:index, :show]
  resources :users, only: [:index, :show]

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
