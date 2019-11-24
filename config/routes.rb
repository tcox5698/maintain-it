# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :chores
    resources :scheduled_chores
    resources :sites
    resources :site_members

    root to: 'users#index'
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

# == Route Map
#
#                     Prefix Verb   URI Pattern                                                                              Controller#Action
#                admin_users GET    /admin/users(.:format)                                                                   admin/users#index
#                            POST   /admin/users(.:format)                                                                   admin/users#create
#             new_admin_user GET    /admin/users/new(.:format)                                                               admin/users#new
#            edit_admin_user GET    /admin/users/:id/edit(.:format)                                                          admin/users#edit
#                 admin_user GET    /admin/users/:id(.:format)                                                               admin/users#show
#                            PATCH  /admin/users/:id(.:format)                                                               admin/users#update
#                            PUT    /admin/users/:id(.:format)                                                               admin/users#update
#                            DELETE /admin/users/:id(.:format)                                                               admin/users#destroy
#               admin_chores GET    /admin/chores(.:format)                                                                  admin/chores#index
#                            POST   /admin/chores(.:format)                                                                  admin/chores#create
#            new_admin_chore GET    /admin/chores/new(.:format)                                                              admin/chores#new
#           edit_admin_chore GET    /admin/chores/:id/edit(.:format)                                                         admin/chores#edit
#                admin_chore GET    /admin/chores/:id(.:format)                                                              admin/chores#show
#                            PATCH  /admin/chores/:id(.:format)                                                              admin/chores#update
#                            PUT    /admin/chores/:id(.:format)                                                              admin/chores#update
#                            DELETE /admin/chores/:id(.:format)                                                              admin/chores#destroy
#     admin_scheduled_chores GET    /admin/scheduled_chores(.:format)                                                        admin/scheduled_chores#index
#                            POST   /admin/scheduled_chores(.:format)                                                        admin/scheduled_chores#create
#  new_admin_scheduled_chore GET    /admin/scheduled_chores/new(.:format)                                                    admin/scheduled_chores#new
# edit_admin_scheduled_chore GET    /admin/scheduled_chores/:id/edit(.:format)                                               admin/scheduled_chores#edit
#      admin_scheduled_chore GET    /admin/scheduled_chores/:id(.:format)                                                    admin/scheduled_chores#show
#                            PATCH  /admin/scheduled_chores/:id(.:format)                                                    admin/scheduled_chores#update
#                            PUT    /admin/scheduled_chores/:id(.:format)                                                    admin/scheduled_chores#update
#                            DELETE /admin/scheduled_chores/:id(.:format)                                                    admin/scheduled_chores#destroy
#                admin_sites GET    /admin/sites(.:format)                                                                   admin/sites#index
#                            POST   /admin/sites(.:format)                                                                   admin/sites#create
#             new_admin_site GET    /admin/sites/new(.:format)                                                               admin/sites#new
#            edit_admin_site GET    /admin/sites/:id/edit(.:format)                                                          admin/sites#edit
#                 admin_site GET    /admin/sites/:id(.:format)                                                               admin/sites#show
#                            PATCH  /admin/sites/:id(.:format)                                                               admin/sites#update
#                            PUT    /admin/sites/:id(.:format)                                                               admin/sites#update
#                            DELETE /admin/sites/:id(.:format)                                                               admin/sites#destroy
#         admin_site_members GET    /admin/site_members(.:format)                                                            admin/site_members#index
#                            POST   /admin/site_members(.:format)                                                            admin/site_members#create
#      new_admin_site_member GET    /admin/site_members/new(.:format)                                                        admin/site_members#new
#     edit_admin_site_member GET    /admin/site_members/:id/edit(.:format)                                                   admin/site_members#edit
#          admin_site_member GET    /admin/site_members/:id(.:format)                                                        admin/site_members#show
#                            PATCH  /admin/site_members/:id(.:format)                                                        admin/site_members#update
#                            PUT    /admin/site_members/:id(.:format)                                                        admin/site_members#update
#                            DELETE /admin/site_members/:id(.:format)                                                        admin/site_members#destroy
#                 admin_root GET    /admin(.:format)                                                                         admin/users#index
#           scheduled_chores GET    /scheduled_chores(.:format)                                                              scheduled_chores#index
#                            POST   /scheduled_chores(.:format)                                                              scheduled_chores#create
#        new_scheduled_chore GET    /scheduled_chores/new(.:format)                                                          scheduled_chores#new
#       edit_scheduled_chore GET    /scheduled_chores/:id/edit(.:format)                                                     scheduled_chores#edit
#            scheduled_chore GET    /scheduled_chores/:id(.:format)                                                          scheduled_chores#show
#                            PATCH  /scheduled_chores/:id(.:format)                                                          scheduled_chores#update
#                            PUT    /scheduled_chores/:id(.:format)                                                          scheduled_chores#update
#                            DELETE /scheduled_chores/:id(.:format)                                                          scheduled_chores#destroy
#                     chores GET    /chores(.:format)                                                                        chores#index
#                            POST   /chores(.:format)                                                                        chores#create
#                  new_chore GET    /chores/new(.:format)                                                                    chores#new
#                 edit_chore GET    /chores/:id/edit(.:format)                                                               chores#edit
#                      chore GET    /chores/:id(.:format)                                                                    chores#show
#                            PATCH  /chores/:id(.:format)                                                                    chores#update
#                            PUT    /chores/:id(.:format)                                                                    chores#update
#                            DELETE /chores/:id(.:format)                                                                    chores#destroy
#     check_in_start_visitor GET    /check_in/start_visitor(.:format)                                                        check_in#start_visitor
#  check_in_check_in_visitor POST   /check_in/check_in_visitor(.:format)                                                     check_in#check_in_visitor
#                            GET    /chores(.:format)                                                                        chores#index
#                            POST   /chores(.:format)                                                                        chores#create
#                            GET    /chores/new(.:format)                                                                    chores#new
#                            GET    /chores/:id/edit(.:format)                                                               chores#edit
#                            GET    /chores/:id(.:format)                                                                    chores#show
#                            PATCH  /chores/:id(.:format)                                                                    chores#update
#                            PUT    /chores/:id(.:format)                                                                    chores#update
#                            DELETE /chores/:id(.:format)                                                                    chores#destroy
#               site_members GET    /site_members(.:format)                                                                  site_members#index
#                            POST   /site_members(.:format)                                                                  site_members#create
#            new_site_member GET    /site_members/new(.:format)                                                              site_members#new
#           edit_site_member GET    /site_members/:id/edit(.:format)                                                         site_members#edit
#                site_member GET    /site_members/:id(.:format)                                                              site_members#show
#                            PATCH  /site_members/:id(.:format)                                                              site_members#update
#                            PUT    /site_members/:id(.:format)                                                              site_members#update
#                            DELETE /site_members/:id(.:format)                                                              site_members#destroy
#                      sites GET    /sites(.:format)                                                                         sites#index
#                            POST   /sites(.:format)                                                                         sites#create
#                   new_site GET    /sites/new(.:format)                                                                     sites#new
#                  edit_site GET    /sites/:id/edit(.:format)                                                                sites#edit
#                       site GET    /sites/:id(.:format)                                                                     sites#show
#                            PATCH  /sites/:id(.:format)                                                                     sites#update
#                            PUT    /sites/:id(.:format)                                                                     sites#update
#                            DELETE /sites/:id(.:format)                                                                     sites#destroy
#           new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#               user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#       destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#          new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#         edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#              user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                            PUT    /users/password(.:format)                                                                devise/passwords#update
#                            POST   /users/password(.:format)                                                                devise/passwords#create
#   cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#      new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#     edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#          user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                            PUT    /users(.:format)                                                                         devise/registrations#update
#                            DELETE /users(.:format)                                                                         devise/registrations#destroy
#                            POST   /users(.:format)                                                                         devise/registrations#create
#      new_user_confirmation GET    /users/confirmation/new(.:format)                                                        devise/confirmations#new
#          user_confirmation GET    /users/confirmation(.:format)                                                            devise/confirmations#show
#                            POST   /users/confirmation(.:format)                                                            devise/confirmations#create
#              welcome_index GET    /welcome/index(.:format)                                                                 welcome#index
#                       root GET    /                                                                                        welcome#index
#         rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#  rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#         rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#  update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#       rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
