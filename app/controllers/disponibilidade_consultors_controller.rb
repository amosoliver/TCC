class DisponibilidadeConsultorsController < ApplicationController
  before_action :set_disponibilidade_consultor, only: %i[show edit update destroy]
  before_action :authenticate_user! # Exige autenticação
  before_action :restrict_access_for_consultor, except: [:index, :show] # Restringe se for consultor

  # GET /disponibilidade_consultors or /disponibilidade_consultors.json
  def index
    if user_signed_in? && current_user.consultor?
      @disponibilidade_consultors = DisponibilidadeConsultor.where(consultor_id: current_user.id).group_by { |d| d.data }
    else
      @disponibilidade_consultors = {}
      flash[:alert] = "Você não tem permissão para acessar essa página."
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

  def create
    @disponibilidade_consultor = DisponibilidadeConsultor.new(disponibilidade_consultor_params)

    respond_to do |format|
      if @disponibilidade_consultor.save
        flash[:notice] = "Disponibilidade consultor foi criada com sucesso."
        format.html { redirect_to disponibilidade_consultors_path }
        format.json { render :show, status: :created, location: @disponibilidade_consultor }
      else
        flash.now[:alert] = "Erro ao criar disponibilidade consultor. Verifique os dados e tente novamente."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @disponibilidade_consultor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @disponibilidade_consultor.update(disponibilidade_consultor_params)
        flash[:notice] = "Disponibilidade consultor foi atualizada com sucesso."
        format.html { redirect_to disponibilidade_consultors_path }
        format.json { render :show, status: :ok, location: @disponibilidade_consultor }
      else
        flash.now[:alert] = "Erro ao atualizar disponibilidade consultor. Verifique os dados e tente novamente."
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @disponibilidade_consultor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disponibilidade_consultors/1 or /disponibilidade_consultors/1.json
  def destroy
    @disponibilidade_consultor.destroy!

    respond_to do |format|
      flash[:notice] = "Disponibilidade consultor foi removida com sucesso."
      format.html { redirect_to disponibilidade_consultors_path, status: :see_other }
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

  def restrict_access_for_consultor
    if !current_user.consultor
      redirect_to disponibilidade_consultors_path, alert: "Acesso restrito para consultor"
    end
  end
end
