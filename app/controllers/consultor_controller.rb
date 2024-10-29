class ConsultorController < ApplicationController
  before_action :set_consultor, only: [:show, :edit, :update, :destroy]

  def index
    # Exibe apenas usuários que são consultores
    @consultores = User.where(consultor: true)
  end

  def show
    @agendamentos = Agendamento.includes(:cliente)
      .where(consultor_id: @consultor.id)
      .order(:data, :hora_inicio)
  
    @disponibilidade = DisponibilidadeConsultor
      .select('DATE(data) AS data, hora_inicio, hora_fim')
      .group('DATE(data)')
  
    # Criando um hash para armazenar os horários ocupados
    ocupados = {}
    @agendamentos.each do |agendamento|
      data = agendamento.data.to_date
      hora_inicio = agendamento.hora_inicio.strftime("%H:%M")
      hora_fim = agendamento.hora_fim.strftime("%H:%M")
  
      # Adicionando os horários ao hash de ocupados
      ocupados[data] ||= []
      ocupados[data] << { inicio: hora_inicio, fim: hora_fim }
    end
  
    @resultado = @disponibilidade.map do |disp|
      data = disp.data.to_date
      hora_inicio = disp.hora_inicio.strftime("%H:%M")
      hora_fim = disp.hora_fim.strftime("%H:%M")
  
      # Gerar todos os horários entre hora_inicio e hora_fim
      horas = []
      current_time = Time.parse(hora_inicio)
      end_time = Time.parse(hora_fim)
  
      while current_time < end_time
        formatted_time = current_time.strftime("%H:%M")
        ocupado = ocupados[data]&.any? do |ocupado_horario|
          formatted_time >= ocupado_horario[:inicio] && formatted_time < ocupado_horario[:fim]
        end
  
        horas << { hora: formatted_time, ocupado: ocupado }
        current_time += 30.minutes # Adiciona 30 minutos, ajuste se necessário
      end
  
      {
        data: data,
        horas: horas
      }
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
