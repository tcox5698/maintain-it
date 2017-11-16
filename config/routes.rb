Rails.application.routes.draw do
  get 'check_in/start_visitor'
  post 'check_in/check_in_visitor'

  resources :site_members
  resources :sites
  devise_for :users
  get 'welcome/index'

  root 'welcome#index'
end
