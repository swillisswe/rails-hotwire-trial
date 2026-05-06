Rails.application.routes.draw do
  root "photos#index"

  resource :session, only: [:new, :create, :destroy]
  resources :photos, only: [:index] do
    resource :like, only: [:create, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
