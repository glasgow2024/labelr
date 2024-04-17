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

  resources :impressions, path: 'impression'

  get "registration/registrant/columns", to: 'registration/registrants#columns'
  get "registration/staff/columns", to: 'registration/staff#columns'
  namespace :registration do
    resources :staff, path: 'staff'
    resources :registrants, path: 'registrant'
    resources :products, path: 'product'
  end
end
