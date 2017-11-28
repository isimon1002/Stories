Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :welcome
  resources :genres, only: [:index, :show] do
      resources :tales, except: [:index]
    end
  resources :tales, only: [] do
     resources :comments, only: [:create, :destroy]
     resources :favorites, only: [:create, :destroy]
     post '/up-vote' => 'votes#up_vote', as: :up_vote
     post '/down-vote' => 'votes#down_vote', as: :down_vote
  end
  get 'about' => 'welcome#about'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
