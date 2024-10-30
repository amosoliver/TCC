class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :allow_access_to_home_index?
  before_action :check_permissions

  private

  # Permite o acesso à home#index para qualquer usuário, logado ou não
  def allow_access_to_home_index?
    controller_name == 'home' && action_name == 'index'
  end

  def check_permissions
    if current_user
      if current_user.consultor?
        # Consultores podem ver tudo
        return true
      elsif !current_user.consultor?
        # Clientes podem ver apenas index e show, exceto para agendamento
        if allowed_action_for_cliente?
          return true
        end
      end
    end

    # Se o usuário não tiver permissão, redireciona
    flash[:alert] = "Acesso restrito."
    redirect_back(fallback_location: root_path)
  end

  def allowed_action_for_cliente?
    allowed_controllers = %w[especialidades areas consultor cidades disponibilidade_consultors]
    allowed_actions = %w[index show]

    agendamento_controller = 'agendamento'
    agendamento_actions = %w[index show] # Permite index e show apenas

    # Verifica se a ação é permitida para clientes
    if allowed_controllers.include?(controller_name) && allowed_actions.include?(action_name)
      return true
    elsif controller_name == agendamento_controller && agendamento_actions.include?(action_name)
      return true
    end

    false
  end
end
