Rails.application.routes.draw do
  devise_for :users, path: 'auth',
    controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations',
      unlocks: 'users/unlocks'
    }, defaults: { format: :json }

  #
  get "home/index"  
  root to: "home#index"

  resources :users, path: 'user'
  get 'user/session/me', to: 'users#me'

  get "registration/registrant/columns", to: 'registration/registrants#columns'
  namespace :registration do
    resources :registrants, path: 'registrant'
  end

  # Catch all for vue router
  get '*path', to: 'home#index', constraints: -> (request) do
    !request.xhr? && request.format.html?
  end
end
