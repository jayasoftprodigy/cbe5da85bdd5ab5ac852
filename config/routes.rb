Rails.application.routes.draw do
  resources :answers
  resources :questions do
    member do
      get "follow_users"
      get "follow_topic"
    end
  end
  devise_for :users
  root to: "questions#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
