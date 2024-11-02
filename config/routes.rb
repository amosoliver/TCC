Rails.application.routes.draw do
  devise_for :users, only: [:sessions] # Desabilita as rotas padrão para sessões e registros

  # Outras rotas
  resources :users, as: 'usuarios'
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
