class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_or_users_controller?

  private

  def devise_or_users_controller?
    # Permite acesso a qualquer rota do Devise e a qualquer ação do UsersController
    devise_controller? || controller_name == 'users'
  end
end
