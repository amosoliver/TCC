class ApplicationController < ActionController::Base
    before_action :authenticate_user!, unless: -> { public_route? }
    before_action :check_permissions, if: -> { user_signed_in? }
  
    private
  
    # Define as rotas públicas que podem ser acessadas sem autenticação
    def public_route?
      devise_controller? || (controller_name == 'home' && action_name == 'index') || (controller_name == 'users' && action_name == 'new') 
    end
  
    def check_permissions
      # Usuários com consultor = false podem acessar index e show de qualquer controller,
      # e no controller agendamento, podem acessar todas as rotas
      if current_user.consultor == false
        return if controller_name == 'agendamento' || action_name.in?(%w[index show])
      end
  
      # Redireciona para a página inicial se não tiver permissão
      redirect_to root_path, alert: 'Você não tem permissão para acessar esta página.'
    end
  end
  