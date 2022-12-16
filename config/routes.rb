Rails.application.routes.draw do
  get 'rooms/index'
  resources :appointments
  resources :patients
  resources :physicians
  resources :services
  resources :rooms do
    resources :messages
  end
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#dashboard"
end
