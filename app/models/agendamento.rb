class Agendamento < ApplicationRecord
  belongs_to :cliente, class_name: 'User', foreign_key: 'cliente_id'
  belongs_to :consultor, class_name: 'User', foreign_key: 'consultor_id'
  belongs_to :disponibilidade_consultor, class_name: 'DisponibilidadeConsultor', foreign_key: 'disponibilidade_id'

  validate :consultor_disponivel_no_horario

  private

  def consultor_disponivel_no_horario
    # Busca a disponibilidade do consultor para a data especificada
    disponibilidade = DisponibilidadeConsultor.find_by(consultor_id: consultor_id, data: data)

    if disponibilidade.nil? ||
       hora_inicio < disponibilidade.hora_inicio ||
       hora_fim > disponibilidade.hora_fim
      errors.add(:base, "O consultor não está disponível nesse horário.")
    end
  end
end
