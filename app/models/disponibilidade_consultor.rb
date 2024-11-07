class DisponibilidadeConsultor < ApplicationRecord
  belongs_to :consultor, class_name: 'User', foreign_key: 'consultor_id'
  validate :validar_disponibilidade

  private

  def validar_disponibilidade
    # Verifica se há um conflito de horário com outro registro para o mesmo consultor e data
    conflitos = DisponibilidadeConsultor.where(consultor_id: consultor_id, data: data)
                                        .where.not(id: id)
                                        .where("(hora_inicio < ? AND hora_fim > ?) OR (hora_inicio < ? AND hora_fim > ?)",
                                               hora_fim, hora_inicio, hora_inicio, hora_fim)

    errors.add(:base, "Conflito de horário com outro agendamento") if conflitos.exists?
  end
end
