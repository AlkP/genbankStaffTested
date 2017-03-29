Rails.application.routes.draw do
  
  post '/tinymce_assets' => 'tinymce_assets#create'
  patch '/staff_tests/:staff_test_id/access_times' => 'access_times#update'
  
  devise_for :users
  
  resources  :structures
  resources :roles
  resources :groups
  resources :nomenclatures
  resources :staff_tests do
    resources :access_times
  end
    
  resources :users do
    resources :structures
    resources :roles
    resources :groups
    resources :nomenclatures
  end

  get "/edit_password/:id" => "users#edit_password", as: "edit_password"
  patch "/update_password/:id" => "users#update_password", as: "update_password"
  post "/user/:user_id/:group_id"=> "users#add_group", as: "add_group"
  delete "/user/:user_group_id/group"=> "users#delete_group", as: "delete_group"
  
  root 'home#show'

  get "/*other_all_page" => 'home#show'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
