class User < ApplicationRecord
  # Associação para clientes
  has_many :agendamentos, foreign_key: 'cliente_id', class_name: 'Agendamento'
  
  # Associação para consultores
  has_many :disponibilidade_consultors, foreign_key: 'consultor_id', class_name: 'DisponibilidadeConsultor'
  has_many :agendamentos_as_consultor, foreign_key: 'consultor_id', class_name: 'Agendamento'

  # Validação para garantir que o usuário tenha uma especialidade se for um consultor
  validates :especialidade_id, presence: true, if: :consultor?

  def consultor?
    consultor # Retorna true ou false baseado no atributo
  end

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
end
