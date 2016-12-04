Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static#index'
  get 'messages/webhook', to: 'messages#webhook'
  post 'messages/webhook', to: 'messages#incoming'

  # Facebook oauth endpoint
  get '/users/login_success', to: 'users#login_success'

  # User newsfeed and profile stuff
  get '/users/:user_id/newsfeed', to: 'users#newsfeed', as: :user_newsfeed
  get '/users/:user_id/friends', to: 'users#friends', as: :user_friends
  get '/users/:user_id/activity', to: 'users#activity', as: :user_activity
  get '/users/:user_id/goals', to: 'users#goals', as: :user_goals
  get '/users/:user_id/interests', to: 'users#interests', as: :user_interests
  get '/users/:user_id/availability', to: 'users#availability', as: :user_availability

  # Invites
  get '/users/:user_id/invites/new', to: 'invites#new', as: :new_invite
  get '/users/:user_id/invites/upcoming', to: 'invites#upcoming', as: :upcoming_invites
  get '/invites/:id/respond', to: 'invites#respond', as: :respond_invite

  # Jeanine routes
  get '/users/:user_id/edit_interests', to: 'users#edit_interests', as: :edit_interests
  post '/users/:user_id/set_interests', to: 'users#set_interests', as: :set_interests
  post '/invites/:id/create_invite', to: 'invites#create_invite', as: :create_invite
end