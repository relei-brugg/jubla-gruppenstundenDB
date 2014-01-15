GruppenstundenDB::Application.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'

  root  'static_pages#home'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
    member do
      get 'toggle_moderator'
      get 'toggle_admin'
      get 'ideas', to: 'ideas#user'
    end
  end

  resources :ideas do
    resources :comments
    member do
      post 'toggle_published'
      get 'print'
    end
    collection do
      get 'unpublished'
      get 'top_rated'
      get 'most_viewed'
    end
  end
  resources :idea_ratings, only: [:create, :update]

end
