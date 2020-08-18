Rails.application.routes.draw do
  # devise_for :users
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
  get 'users', to: 'users#index'
  get '/logged', to: 'sessions#logged_in'
  devise_scope :user do
    delete '/signout', to: 'sessions#delete'
    get '/loggeduser', to: 'sessions#logged?'

  end
  resources :curriculums
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
