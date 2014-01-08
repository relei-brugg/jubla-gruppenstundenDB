GruppenstundenDB::Application.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'

  root  'static_pages#home'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :ideas do
    resources :comments
    member do
      get 'publish'
    end
  end
  resources :idea_ratings, only: [:create, :update]

end
