class ApplicationController < ActionController::Base
  before_action :allow_public_access
  before_action :authorize_user_access

  private

  def allow_public_access
    if public_access?
      # Permite acesso sem autenticação
    else
      authenticate_user! # Exemplo se você estiver usando Devise
    end
  end

  def authorize_user_access
    return if user_consultor_access? # Permite acesso total se o usuário for consultor

    # Restringe as ações permitidas para não consultores
    allowed_actions = %i[index show ]
    
    # Permite ações 'new' e 'create' apenas para a controller 'agendamentos'
    if controller_name == 'agendamentos'
      allowed_actions += %i[new create]
    end

    # Verifica se a ação atual está nas ações permitidas
    unless allowed_actions.include?(action_name.to_sym)
      redirect_back(fallback_location: root_path, alert: 'Acesso negado.') # Redireciona caso não tenha permissão
    end
  end

  def public_access?
    request.path == new_usuario_path ||
      request.path == usuarios_path ||
      request.path == root_path || # rota home com a action index
      request.path == new_user_session_path ||
      request.path == user_session_path
  end

  def user_consultor_access?
    # Verifica se o usuário está logado e se o campo consultor é verdadeiro
    current_user.present? && current_user.consultor?
  end
end
