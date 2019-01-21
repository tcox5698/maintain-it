Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :chores
      resources :scheduled_chores
      resources :sites
      resources :site_members

      root to: "users#index"
    end
  resources :scheduled_chores
  resources :chores
  get 'check_in/start_visitor'
  post 'check_in/check_in_visitor'

  resources :chores
  resources :site_members
  resources :sites
  devise_for :users
  get 'welcome/index'

  root 'welcome#index'
end
