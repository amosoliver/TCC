Rails.application.routes.draw do
  devise_for :users, only: [:sessions, :registrations] # Adicione registrations se necessário

  resources :users, as: 'usuarios' # Muda o nome da rota para 'administrators'
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
