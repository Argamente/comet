Rails.application.routes.draw do
  root to: 'static_pages#home'


  match '/signup', to: 'user_accounts#signup', via: 'get'
  match '/signin', to: 'user_accounts#signin', via: 'get'
  match '/create', to: 'user_accounts#create', via: 'post'


end
