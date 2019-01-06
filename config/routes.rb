Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :trips, only: [:index, :show]
  resources :trails, only: [:show] do
    resources :water_sources, only: [:index, :show]
  end
  
  namespace :admin do
    resources :trails, only: [:show, :edit] do
      resources :water_sources, shallow: true
    end
  end
end
