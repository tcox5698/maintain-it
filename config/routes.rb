Rails.application.routes.draw do
  resources :sites
  devise_for :users
  get 'welcome/index'

  root 'welcome#index'
end
