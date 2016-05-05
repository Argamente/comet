Rails.application.routes.draw do
  root to: 'static_pages#home'


  match '/signup', to: 'user_accounts#signup', via: 'get'
  match '/signin', to: 'user_accounts#signin', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'get'
  match '/resetpassword', to: 'user_accounts#resetpassword', via: 'get'
  match '/active', to:'user_accounts#active', via: 'get'
  match '/changepassword', to:'user_accounts#change_password', via: 'get'

  match '/tosignup', to: 'user_accounts#tosignup', via: 'post'
  match '/tosignin',  to: 'sessions#tosignin', via: 'post'
  match '/toresetpassword', to: 'user_accounts#toresetpassword', via: 'post'


end
