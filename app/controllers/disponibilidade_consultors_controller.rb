class DisponibilidadeConsultorsController < ApplicationController
  before_action :set_disponibilidade_consultor, only: %i[ show edit update destroy ]

  # GET /disponibilidade_consultors or /disponibilidade_consultors.json
  def index
# Primeiro, verifique se o usuário está logado e é um consultor
if user_signed_in? && current_user.consultor?
  @disponibilidade_consultors = DisponibilidadeConsultor.where(consultor_id: current_user.id)
else
  @disponibilidade_consultors = DisponibilidadeConsultor.none # Retorna uma coleção vazia se não for consultor
end
  end

  # GET /disponibilidade_consultors/1 or /disponibilidade_consultors/1.json
  def show
  end

  # GET /disponibilidade_consultors/new
  def new
    @disponibilidade_consultor = DisponibilidadeConsultor.new
  end

  # GET /disponibilidade_consultors/1/edit
  def edit
  end

  # POST /disponibilidade_consultors or /disponibilidade_consultors.json
  def create
    @disponibilidade_consultor = DisponibilidadeConsultor.new(disponibilidade_consultor_params)

    respond_to do |format|
      if @disponibilidade_consultor.save
        format.html { redirect_to @disponibilidade_consultor, notice: "Disponibilidade consultor was successfully created." }
        format.json { render :show, status: :created, location: @disponibilidade_consultor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @disponibilidade_consultor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disponibilidade_consultors/1 or /disponibilidade_consultors/1.json
  def update
    respond_to do |format|
      if @disponibilidade_consultor.update(disponibilidade_consultor_params)
        format.html { redirect_to @disponibilidade_consultor, notice: "Disponibilidade consultor was successfully updated." }
        format.json { render :show, status: :ok, location: @disponibilidade_consultor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @disponibilidade_consultor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disponibilidade_consultors/1 or /disponibilidade_consultors/1.json
  def destroy
    @disponibilidade_consultor.destroy!

    respond_to do |format|
      format.html { redirect_to disponibilidade_consultors_path, status: :see_other, notice: "Disponibilidade consultor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disponibilidade_consultor
      @disponibilidade_consultor = DisponibilidadeConsultor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def disponibilidade_consultor_params
      params.require(:disponibilidade_consultor).permit(:consultor_id, :data, :hora_inicio, :hora_fim)
    end
end
