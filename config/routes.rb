Rails.application.routes.draw do
  root to: 'static_pages#home'


  match '/signup', to: 'user_accounts#signup', via: 'post'
  match '/signin', to: 'user_accounts#signin', via: 'post'


end
