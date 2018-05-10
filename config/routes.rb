Rails.application.routes.draw do
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
