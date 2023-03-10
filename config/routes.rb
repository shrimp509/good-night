Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :clock_ins, only: [:create, :index]
      resources :follows, only: [:create]
      delete :unfollows, to: 'follows#unfollows'
      get 'sleep_ranking', to: 'follows#sleep_ranking'
    end
  end
end
