class Agendamento < ApplicationRecord
  belongs_to :cliente, class_name: 'User', foreign_key: 'cliente_id'
  belongs_to :consultor, class_name: 'User', foreign_key: 'consultor_id'
  belongs_to :disponibilidade_consultor, class_name: 'DisponibilidadeConsultor', foreign_key: 'disponibilidade_id'

  # Validação para garantir que o consultor_id só pode ser vinculado a um usuário consultor
  validate :consultor_must_be_valid
  validates :disponibilidade_consultor, presence: { message: 'é obrigatório' }

  private

  def consultor_must_be_valid
    if consultor_id.present? && User.find(consultor_id).consultor == false
      errors.add(:consultor_id, 'não pode ser vinculado a um usuário que não é um consultor.')
    end
  end
end
