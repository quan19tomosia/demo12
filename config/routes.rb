Rails.application.routes.draw do
  resources :users, only: [:index] do
    member do
      patch :ban
    end
  end
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
