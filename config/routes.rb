Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root "dashboard#show"

  resources :contacts do
    resources :activities, only: %i[new create]
  end

  resources :leads do
    resources :activities, only: %i[new create]
  end
end
