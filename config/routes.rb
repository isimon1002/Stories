Rails.application.routes.draw do

  devise_for :users
  resources :welcome
  resources :tales
  get 'about' => 'welcome#about'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
