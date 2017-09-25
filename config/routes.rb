Rails.application.routes.draw do
  get 'check_in/start_visitor'

  resources :site_members
  resources :sites
  devise_for :users
  get 'welcome/index'

  root 'welcome#index'
end
