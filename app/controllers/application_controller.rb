class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :allow_access_to_home_index?
  before_action :check_consultor_permissions

  private

  def users_new_or_create?
    controller_name == 'users' && %w[new create].include?(action_name)
  end

  def allow_access_to_home_index?
    controller_name == 'home' && action_name == 'index'
  end

  def check_consultor_permissions
    if current_user&.consultor? && !allowed_action_for_consultor?
      flash[:alert] = "Acesso restrito para consultores."
      redirect_back(fallback_location: root_path)
    end
  end

  def allowed_action_for_consultor?
    allowed_controllers = %w[especialidades areas consultor cidades disponibilidade_consultors]
    allowed_actions = %w[index show]

    devise_controllers = %w[sessions registrations passwords confirmations unlocks]

    user_controllers = %w[users]
    user_actions = %w[index show new create edit update destroy]

    if allowed_controllers.include?(controller_name) && allowed_actions.include?(action_name)
      return true
    end

    return true if devise_controllers.include?(controller_name)

    if user_controllers.include?(controller_name) && user_actions.include?(action_name)
      return true
    end

    !current_user&.consultor?
  end
end
