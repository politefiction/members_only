Rails.application.routes.draw do
  resources :users
  root 'static_pages#home'

  #get 'users/new'
  #post 'user'
  #get 'users/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
