Rails.application.routes.draw do
  resources :players
  resources :devices
  resources :offers do
    resources :offer_targets, path: 'targets', only: [:index]
  end
  
  resources :offer_targets


  root to: 'players#index'
end


# web: bin/rails server -p 3000