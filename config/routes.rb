Rails.application.routes.draw do
  
  root to: 'home#index'
  
  resources :gifts
  
  resources :merchants, only: [:show, :index] do
    put :verification
    post :bank_account
    get :payment
    post :payment_stripe
    get :confirmation
  end
  
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks',
  }
  
end
