class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :users_new_or_create?
  before_action :check_consultor_permissions

  private

  # Método para verificar se é o UsersController com as ações new ou create
  def users_new_or_create?
    controller_name == 'users' && %w[new create].include?(action_name)
  end

  def check_consultor_permissions
    # Verifica se o usuário é um consultor e está tentando acessar rotas restritas
    if current_user&.consultor? && !allowed_action_for_consultor?
      flash[:alert] = "Acesso restrito para consultores."
      redirect_back(fallback_location: root_path)
    end
  end

  def allowed_action_for_consultor?
    # Permite ações específicas para consultores
    allowed_controllers = %w[especialidades areas consultor cidades disponibilidade_consultors]
    allowed_actions = %w[index show]

    # Permite rotas do Devise
    devise_controllers = %w[sessions registrations passwords confirmations unlocks]

    # Permite as ações do controller de users
    user_controllers = %w[users]
    user_actions = %w[index show new create edit update destroy] # Todas as ações CRUD

    # Verifica se está em um controller permitido
    if allowed_controllers.include?(controller_name) && allowed_actions.include?(action_name)
      return true
    end

    # Verifica se está em um controller do Devise
    return true if devise_controllers.include?(controller_name)

    # Verifica se está no controller de users e nas ações permitidas
    if user_controllers.include?(controller_name) && user_actions.include?(action_name)
      return true
    end

    # Se não for consultor, permite o acesso
    !current_user&.consultor?
  end
end
