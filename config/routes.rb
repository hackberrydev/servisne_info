Rails.application.routes.draw do
  devise_for :users

  root "pages#index"

  namespace :admin do
    resources :users, :only => :index
  end
end
