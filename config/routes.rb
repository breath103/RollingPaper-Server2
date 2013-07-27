require 'sidekiq/web'
RollingPaper::Application.routes.draw do
  devise_for :admins

  post "users/login" => "logins#sign_in_with_facebook"
  resources :papers 

  mount API => '/api'
  resources :image_contents, path: '/api/image_contents'
  resources :sound_contents, path: '/api/sound_contents'
#  resources :admin
  resources :admin_notifications, path: "/admin/notifications"
  
  get "/" => "users#home"
  
  mount Sidekiq::Web, at: '/sidekiq'
end
