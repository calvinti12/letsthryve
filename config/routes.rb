Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static#index'
  get 'messages/webhook', to: 'messages#webhook'
  post 'messages/webhook', to: 'messages#incoming'

  scope 'webview', as: 'webview' do
    get 'login', to: 'webview#login'
  end
end