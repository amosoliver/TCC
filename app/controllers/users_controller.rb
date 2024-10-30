class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_cidades_and_especialidades, only: %i[new create edit]

  # GET /users or /users.json
  def index
    @users = User.all
    # @cidades e @especialidades já serão definidas pelo before_action
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new # Isso renderiza a view `new` onde as variáveis já estão definidas
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit # Isso renderiza a view `edit` onde as variáveis já estão definidas
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
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
