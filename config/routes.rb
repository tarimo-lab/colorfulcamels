Rails.application.routes.draw do
  
  mount ActionCable.server => '/cable'

  root 'home#index'

  get 'home/index'
  get 'home/about'
  get 'home/search'
  get 'home/feedback'

  devise_for :users

  # Provides default path for signed in users
  match 'user_root' => 'users#show', via: :all

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end

  resources :posts do
    resources :comments
  end
  
end
