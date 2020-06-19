Rails.application.routes.draw do
  
  devise_for :users

  mount ActionCable.server => '/cable'

  root 'home#index'

  get 'home/index'
  get 'home/about'
  get 'home/search'
  get 'home/feedback'

  # Provides default path for signed in users
  match 'user_root' => 'users#show', via: :all
  #match 'users/sign_out' => 'devise/sessions#destroy', via: :all

  devise_scope :user do
    get 'sign_in' => 'devise/sessions#new'
    get 'users/sign_out'  => 'devise/sessions#destroy'
  end

  resources :posts do
    resources :comments
  end
  
end
