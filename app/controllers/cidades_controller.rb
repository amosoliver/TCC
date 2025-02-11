class CidadesController < ApplicationController
  before_action :authenticate_user! # Exige autenticação
  before_action :restrict_access_for_consultor, except: [:index, :show] # Restringe se for consultor
  before_action :set_cidade, only: %i[ show edit update destroy ]

  # GET /cidades or /cidades.json
  def index
    @cidades = Cidade.all
  end

  # GET /cidades/1 or /cidades/1.json
  def show
# Supondo que o id da cidade é passado na URL
    cidade_id = params[:id]
    @cidade = Cidade.find(cidade_id)
    # Filtrando os consultores onde consultor é true
    @consultores = @cidade.consultores.where(consultor: true)         
  end
  

  # GET /cidades/new
  def new
    @cidade = Cidade.new
  end

  # GET /cidades/1/edit
  def edit
  end

  # POST /cidades or /cidades.json
  def create
    @cidade = Cidade.new(cidade_params)

    respond_to do |format|
      if @cidade.save
        format.html { redirect_to @cidade, notice: "Cidade was successfully created." }
        format.json { render :show, status: :created, location: @cidade }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cidades/1 or /cidades/1.json
  def update
    respond_to do |format|
      if @cidade.update(cidade_params)
        format.html { redirect_to @cidade, notice: "Cidade was successfully updated." }
        format.json { render :show, status: :ok, location: @cidade }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cidades/1 or /cidades/1.json
  def destroy
    @cidade.destroy!

    respond_to do |format|
      format.html { redirect_to cidades_path, status: :see_other, notice: "Cidade was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cidade
      @cidade = Cidade.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cidade_params
      params.require(:cidade).permit(:descricao)
    end
    def restrict_access_for_consultor
      if !current_user.consultor
        redirect_to cidades_path, alert: "Acesso restrito para consultor"
      end
    end
end
