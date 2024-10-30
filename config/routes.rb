Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations] # Desabilita as rotas padrão para sessões e registros

  # Rotas de Sessões
  devise_scope :user do
    get    'users/sign_in', to: 'devise/sessions#new', as: :new_user_session
    post   'users/sign_in', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session # Novo caminho para logout
  end

  # Rotas de Registro
  devise_scope :user do
    get    'users/sign_up', to: 'devise/registrations#new', as: :new_user_registration
    post   'users', to: 'devise/registrations#create', as: :user_registration
    get    'users/edit', to: 'devise/registrations#edit', as: :edit_user_registration
    patch  'users', to: 'devise/registrations#update'
    put    'users', to: 'devise/registrations#update'
    delete 'users', to: 'devise/registrations#destroy'
  end

  # Outras rotas
  resources :users, as: 'usuarios' # Rota para usuários (administradores)
  resources :agendamentos
  resources :disponibilidade_consultors
  resources :cidades
  resources :especialidades
  resources :consultor
  resources :areas

  root to: "home#index"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
