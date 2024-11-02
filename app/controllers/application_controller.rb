class ApplicationController < ActionController::Base
  # Chama o método allow_public_access antes de qualquer ação no controlador
  before_action :allow_public_access  
  # Chama o método authorize_user_access antes de qualquer ação no controlador
  before_action :authorize_user_access  

  private  # As definições de métodos abaixo são privadas e não podem ser acessadas fora desta classe

  # Método para permitir acesso público ou autenticar o usuário
  def allow_public_access
    # Verifica se a rota atual é pública
    if public_access?  
      # Permite acesso sem autenticação para rotas públicas
    else
      # Se não for uma rota pública, chama o método de autenticação do Devise
      authenticate_user!  
    end
  end

  # Método para autorizar o acesso do usuário baseado em seu perfil
  def authorize_user_access
    # Retorna se o usuário for um consultor, permitindo acesso total
    return if user_consultor_access?  

    # Define as ações permitidas para usuários não consultores
    allowed_actions = %i[index show]  

    # Se o controlador atual for 'agendamentos', permite as ações 'new' e 'create'
    if controller_name == 'agendamentos'  
      allowed_actions += %i[new create]  
    end

    # Verifica se a ação atual está na lista de ações permitidas
    unless allowed_actions.include?(action_name.to_sym)  
      # Redireciona o usuário para a página anterior se não tiver permissão
      redirect_back(fallback_location: root_path, alert: 'Acesso negado.')  
    end
  end

  # Método que verifica se a rota atual é uma rota de acesso público
  def public_access?
    # Retorna verdadeiro se a rota for uma das seguintes
    request.path == new_usuario_path ||  # Rota para criar um novo usuário
      request.path == usuarios_path ||    # Rota para listar usuários
      request.path == root_path ||        # Rota da página inicial (index)
      request.path == new_user_session_path || # Rota para o formulário de login
      request.path == user_session_path    # Rota para sessão do usuário
  end

  # Método que verifica se o usuário atual é um consultor
  def user_consultor_access?
    # Retorna verdadeiro se o usuário estiver logado e for um consultor
    current_user.present? && current_user.consultor?  
  end
end
