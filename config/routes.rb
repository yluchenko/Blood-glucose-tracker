Rails.application.routes.draw do
  resources :readings, only: %i[index create new]
  devise_for :users
  get '/search', to: 'readings#search', as: :search, defaults: { format: :turbo_stream }
  root 'readings#index'
end
