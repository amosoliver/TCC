class ConsultorController < ApplicationController
  before_action :set_consultor, only: [:show, :edit, :update, :destroy]

  def index
    # Exibe apenas usuários que são consultores
    @consultores = User.where(consultor: true)
  end

  def show
    @agendamentos = Agendamento.where(consultor_id: @consultor.id)
    
    @calendar_events = @agendamentos.map do |agendamento|
      {
        id: agendamento.id,
        name: "Agendamento com Cliente ##{agendamento.cliente_id}",
        start: agendamento.data.to_time.change(hour: agendamento.hora_inicio.hour, min: agendamento.hora_inicio.min).iso8601,
        end: agendamento.data.to_time.change(hour: agendamento.hora_fim.hour, min: agendamento.hora_fim.min).iso8601,
        color: '#FF5733' 
      }
    end
    
    @disponibilidades = DisponibilidadeConsultor.where(consultor_id: @consultor.id)
  
    available_dates = @disponibilidades.map do |disponibilidade|
      {
        id: "disponibilidade_#{disponibilidade.id}",
        name: "Disponível",
        start: disponibilidade.data.to_time.change(hour: disponibilidade.hora_inicio.hour, min: disponibilidade.hora_inicio.min).iso8601,
        end: disponibilidade.data.to_time.change(hour: disponibilidade.hora_fim.hour, min: disponibilidade.hora_fim.min).iso8601,
        color: '#28A745' 
      }
    end
    
    @calendar_events.concat(available_dates) # Use concat para adicionar os elementos sem mutação
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
