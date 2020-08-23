Rails.application.routes.draw do
  get 'interviews/create'
  get 'interviews/update'
  get 'company_details/create'
  get 'job_offers/create'
  get 'job_offers/index'
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
  get '/users', to: 'users#index'
  get '/logged', to: 'sessions#logged_in'
  get '/applyjobs', to: 'apply_jobs#index'

  post '/applyjobs', to: 'apply_jobs#create'
  devise_scope :user do
    delete '/signout', to: 'sessions#delete'
    get '/loggeduser', to: 'sessions#logged?'
  end

  post '/acceptcandidates', to: 'apply_jobs#accept_application'
  post '/interviews/create', to: 'interviews#create'
  patch 'interviews/update', to: 'interviews#update'
  resources :curriculums
  resources :company_details
  resources :job_offers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
