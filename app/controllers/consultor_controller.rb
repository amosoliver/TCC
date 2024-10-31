class ConsultorController < ApplicationController
  before_action :set_consultor, only: [:show, :edit, :update, :destroy]

  def index
    # Exibe apenas usuários que são consultores
    @consultores = User.where(consultor: true)
  end

  def show
    # Encontra o consultor com base no parâmetro e na função de consultor
    @consultor = User.find(params[:id])
    unless @consultor.consultor?
      redirect_to root_path, alert: "Consultor não encontrado"
      return
    end
  
    # Carrega as disponibilidades do consultor
    disponibilidades = @consultor.disponibilidade_consultors.order(:data, :hora_inicio)
    # Carrega os agendamentos do consultor para marcar os horários ocupados
    agendamentos = @consultor.agendamentos
  
    # Marca as disponibilidades como 'Ocupado' ou 'Agendar' para exibição na view
    @resultado = disponibilidades.map do |disponibilidade|
      # Verifica se existe um agendamento que coincida com a disponibilidade
      status = agendamentos.any? do |a|
        a.data == disponibilidade.data && a.hora_inicio == disponibilidade.hora_inicio
      end ? 'Ocupado' : 'Agendar'
      
      { disponibilidade: disponibilidade, status: status }
    end
  end
  
  
  
  
  def new
    # lógica para mostrar o formulário de novo consultor
    @consultor = User.new
  end

  def create
    # lógica para criar um novo consultor
    @consultor = User.new(consultor_params)
    if @consultor.save
      redirect_to @consultor, notice: 'Consultor criado com sucesso.'
    else
      render :new
    end
  end

  def edit
    # lógica para mostrar o formulário de edição
  end

  def update
    # lógica para atualizar um consultor existente
    if @consultor.update(consultor_params)
      redirect_to @consultor, notice: 'Consultor atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    # lógica para excluir um consultor
    @consultor.destroy
    redirect_to consultores_url, notice: 'Consultor excluído com sucesso.'
  end

  private

  def set_consultor
    # Define o consultor a partir do ID e certifica-se de que é um consultor
    @consultor = User.find(params[:id])
    redirect_to root_path, alert: 'Usuário não é um consultor.' unless @consultor.consultor?
  end

  def consultor_params
    # Permite apenas parâmetros permitidos para um consultor
    params.require(:user).permit(:nome, :email, :especialidade_id, :cidade_id, :descricao, :foto, :consultor)
  end
end
