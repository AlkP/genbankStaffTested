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

  get "/edit_password/:id" => "users#edit_password", as: "edit_password"
  patch "/update_password/:id" => "users#update_password", as: "update_password"
  
  root 'home#show'

  get "/*other_all_page" => 'home#show'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
