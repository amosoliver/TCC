class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_cidades_and_especialidades, only: %i[new create edit]

  # GET /usuarios or /usuarios.json
  def index
    @users = User.all
  end

  # GET /usuarios/1 or /usuarios/1.json
  def show
  end

  # GET /usuarios/new
  def new
    @user = User.new(consultor: params[:consultor] == "true")
  end

  # GET /usuarios/1/edit
  def edit
  end

  # POST /usuarios or /usuarios.json
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to usuario_path(@user), notice: 'Usuário criado com sucesso.'
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence # Exibe os erros e mantém a mensagem na mesma requisição
      render :new # Renderiza a view 'new' para mostrar os erros
    end
  end
  
  def update
    if @user.update(user_params)
      redirect_to usuario_path(@user), notice: 'Usuário atualizado com sucesso.'
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence # Exibe os erros e mantém a mensagem na mesma requisição
      render :edit # Renderiza a view 'edit' para mostrar os erros
    end
  end
  
  

  # DELETE /usuarios/1 or /usuarios/1.json
  def destroy
    @user.destroy
    redirect_to usuarios_path, notice: 'Usuário excluído com sucesso.'
  end

  def logout_and_redirect
    sign_out(current_user)
    redirect_to root_path, notice: "Você saiu da sessão."
  end

  private

  # Callback para definir o usuário
  def set_user
    @user = User.find(params[:id])
  end

  # Callback para definir cidades e especialidades
  def set_cidades_and_especialidades
    @cidades = Cidade.all
    @especialidades = Especialidade.all
  end

  # Strong parameters
  def user_params
    params.require(:user).permit(:email, :nome, :consultor, :especialidade_id, :cidade_id, :password, :password_confirmation)
  end
end
