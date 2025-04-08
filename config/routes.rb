Rails.application.routes.draw do
  namespace :api do
    resources :sessions, only: [:create] do
      collection do
        delete '', to: 'sessions#destroy'
      end
    end
    resources :voters
    resources :candidates
    resources :votes
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  # Catch-all fallback route for client-side routing
  # This will send any request that hasn't been matched above to home#index
  get '*path', to: 'home#index', constraints: ->(req) {
    !req.xhr? && req.format.html?
  }
end
