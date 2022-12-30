Rails.application.routes.draw do
  resources :users, only: [:index] do
    member do
      patch :ban
    end
  end
  resources :appointments do
    get :change_state
  end
  resources :patients
  resources :physicians
  resources :services
  resources :rooms do
    resources :messages
  end
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations', confirmations: 'users/confirmations' }
  
  root "pages#dashboard"
  get "check" => "appointments#check"
  devise_scope :user do
    get "pending" => "users/confirmations#pending"
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
