Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      devise_for :users, singular: :user, path: "users", controllers: {
        sessions: "api/v1/sessions",
        registrations: "api/v1/registrations"
      }

      get "/health", to: "health#show"
    end
  end
end
