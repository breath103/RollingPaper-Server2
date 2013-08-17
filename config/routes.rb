require 'sidekiq/web'
RollingPaper::Application.routes.draw do
  devise_for :admins

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
  resources :papers 
  resources :backgrounds

  mount API => '/api'
  resources :image_contents, path: '/api/image_contents'
  resources :sound_contents, path: '/api/sound_contents'
  resources :admin
  resources :admin_notifications, path: "/admin/notifications"
  
  get "/" => "users#home"
  
  mount Sidekiq::Web, at: '/sidekiq'
end
