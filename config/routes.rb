Rails.application.routes.draw do

  devise_for :users
  resources :welcome
  resources :genres, only: [:index, :show] do
      resources :tales, except: [:index]
    end
  get 'about' => 'welcome#about'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
