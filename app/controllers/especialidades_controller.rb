class EspecialidadesController < ApplicationController
  before_action :set_especialidade, only: %i[ show edit update destroy ]
  before_action :authenticate_user! # Exige autenticação
  before_action :restrict_access_for_consultor, except: [:index, :show] # Restringe se for consultor
  # GET /especialidades or /especialidades.json
  def index
    @especialidades = Especialidade.all
  end

  # GET /especialidades/1 or /especialidades/1.json
  # GET /especialidades/1 or /especialidades/1.json
  def show
    @consultores = User.where(consultor: true, especialidade_id: @especialidade.id)
    # Remover a linha abaixo, pois já temos @especialidade definida pelo set_especialidade
    # @especialidade = Especialidade.where(id: @especialidade.id)
  end
  


  # GET /especialidades/new
  def new
    @especialidade = Especialidade.new
  end

  # GET /especialidades/1/edit
  def edit
  end

  # POST /especialidades or /especialidades.json
  def create
    @especialidade = Especialidade.new(especialidade_params)

    respond_to do |format|
      if @especialidade.save
        format.html { redirect_to @especialidade, notice: "Especialidade was successfully created." }
        format.json { render :show, status: :created, location: @especialidade }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @especialidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /especialidades/1 or /especialidades/1.json
  def update
    respond_to do |format|
      if @especialidade.update(especialidade_params)
        format.html { redirect_to @especialidade, notice: "Especialidade was successfully updated." }
        format.json { render :show, status: :ok, location: @especialidade }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @especialidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /especialidades/1 or /especialidades/1.json
  def destroy
    @especialidade.destroy!

    respond_to do |format|
      format.html { redirect_to especialidades_path, status: :see_other, notice: "Especialidade was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_especialidade
      @especialidade = Especialidade.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def especialidade_params
      params.require(:especialidade).permit(:nome,:descricao, :area_id)
    end

    def restrict_access_for_consultor
      if !current_user.consultor
        redirect_to especialidades_path, alert: "Acesso restrito para consultor"
      end
    end
end
