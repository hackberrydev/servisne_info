Rails.application.routes.draw do
  devise_for :users, 
             :controllers => { 
               :confimations => "users/confirmations",
               :passwords => "users/passwords",
               :registrations => "users/registrations",
               :sessions => "users/sessions",
               :unlocks => "users/unlocks"
             }

  root "pages#index"
  
  get "/about", :to => "pages#about"
  get "/contact", :to => "pages#contact"

  namespace :admin do
    resources :users, :only => :index
  end
end
