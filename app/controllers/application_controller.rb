class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_or_users_controller?

  private

  def devise_or_users_controller?
    # Permite acesso a qualquer rota do Devise, a qualquer ação do UsersController, e à ação index do HomeController
    devise_controller? || controller_name == 'users' || (controller_name == 'home' && action_name == 'index')
  end
end
