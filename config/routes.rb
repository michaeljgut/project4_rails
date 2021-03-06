Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: "/auth"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles

  match 'temp_articles/' => 'temp_articles#destroy_some', :via => :delete, :as => 'destroy_some'

  match 'temp_articles/temp' => 'temp_articles#destroy_temp', :via => :delete, :as => 'destroy_temp'

  match 'topics/save' => 'topics#index_save', :via => :get, :as => 'index_save'

  match 'topics/save' => 'topics#destroy_save', :via => :delete, :as => 'destroy_save'

  resources :temp_articles

  resources :topics

  root to: "articles#index"

end
