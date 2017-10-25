Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: "/auth"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles

  match 'temp_articles/' => 'temp_articles#destroy_some', :via => :delete, :as => 'destroy_some'

  match 'temp_articles/temp' => 'temp_articles#destroy_temp', :via => :delete, :as => 'destroy_temp'

  resources :temp_articles

  resources :topics

  root to: "articles#index"

end
