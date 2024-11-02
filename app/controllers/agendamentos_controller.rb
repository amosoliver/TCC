class AgendamentosController < ApplicationController
  before_action :set_agendamento, only: %i[ show edit update destroy ]

  # GET /agendamentos or /agendamentos.json
  def index
    if current_user.consultor?
      @agendamentos = current_user.agendamentos
        .includes(:cliente)
        .where.not(hora_inicio: nil, hora_fim: nil)
        .group_by { |agendamento| agendamento.data.to_date }
    else
      # Aqui você pode definir como buscar os agendamentos para outros tipos de usuários
      @agendamentos = Agendamento.includes(:cliente)
        .where.not(hora_inicio: nil, hora_fim: nil)
        .group_by { |agendamento| agendamento.data.to_date }
    end
  end
  
  
  # GET /agendamentos/1 or /agendamentos/1.json
  def show
  end

  # GET /agendamentos/new
  def new
    @agendamento = Agendamento.new(
      consultor_id: params[:consultor_id],
      cliente_id: params[:cliente_id],
      data: params[:data] ? Date.parse(params[:data]) : nil,
      hora_inicio: params[:hora_inicio] ? Time.zone.parse(params[:hora_inicio]) : nil,
      hora_fim: params[:hora_fim] ? Time.zone.parse(params[:hora_fim]) : nil,
      disponibilidade_id: params[:disponibilidade_id] # Adicione esta linha
    )
  end
  

  def edit
  end

  # POST /agendamentos or /agendamentos.json
  def create
    @agendamento = Agendamento.new(agendamento_params)
  
    respond_to do |format|
      if @agendamento.save
        format.html { redirect_to @agendamento, notice: "Agendamento was successfully created." }
        format.json { render :show, status: :created, location: @agendamento }
      else
        format.html { redirect_back(fallback_location: new_agendamento_path, alert: "Failed to create Agendamento.") }
        format.json { render json: @agendamento.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /agendamentos/1 or /agendamentos/1.json
  def update
    respond_to do |format|
      if @agendamento.update(agendamento_params)
        format.html { redirect_to @agendamento, notice: "Agendamento was successfully updated." }
        format.json { render :show, status: :ok, location: @agendamento }
      else
        format.html { redirect_back(fallback_location: edit_agendamento_path(@agendamento), alert: "Failed to update Agendamento.") }
        format.json { render json: @agendamento.errors, status: :unprocessable_entity }
      end
    end
  end
  
  

  # DELETE /agendamentos/1 or /agendamentos/1.json
  def destroy
    @agendamento.destroy!

    respond_to do |format|
      format.html { redirect_to agendamentos_path, status: :see_other, notice: "Agendamento was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agendamento
      @agendamento = Agendamento.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def agendamento_params
      params.require(:agendamento).permit(:cliente_id, :disponibilidade_id, :consultor_id, :data, :hora_inicio, :hora_fim)
    end
    
end 
