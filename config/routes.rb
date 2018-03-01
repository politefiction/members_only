Rails.application.routes.draw do
  resources :users
  root 'static_pages#home'

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
