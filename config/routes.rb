Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "courses", to: "courses#all"
  post "courses", to: "courses#create"

  post "students", to: "students#create"

  post "professors", to: "professors#create"

  post "groups", to: "groups#create"

  post "login", to: "users#login"
end
 