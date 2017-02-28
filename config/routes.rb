Rails.application.routes.draw do
  
  devise_for :users
  
  resources  :structures
  resources :roles
  resources :groups
  resources :nomenclatures
    
  resources :users do
    resources :structures
    resources :roles
    resources :groups
    resources :nomenclatures
  end

  root 'home#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
