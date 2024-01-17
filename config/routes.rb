Rails.application.routes.draw do
  get 'home/index'
  get '/helper_bot', to: 'helper_bot#index'
  resources :widget, only: :index

  root 'home#index'
end
