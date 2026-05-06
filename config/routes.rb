Rails.application.routes.draw do
  root "photos#index"

  resource :session, only: [:new, :create, :destroy]
  resources :photos, only: [:index]

  get "up" => "rails/health#show", as: :rails_health_check
end
