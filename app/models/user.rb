class User < ApplicationRecord
  # Associações
  belongs_to :especialidade, optional: true
  belongs_to :cidade, optional: true
  has_many :agendamentos, foreign_key: 'cliente_id', class_name: 'Agendamento'
  has_many :disponibilidade_consultors, foreign_key: 'consultor_id', class_name: 'DisponibilidadeConsultor'
  has_many :agendamentos_as_consultor, foreign_key: 'consultor_id', class_name: 'Agendamento'

  # Validações
  validates :especialidade_id, presence: true, if: :consultor?
  
  # Validações de senha
  validates :password, presence: true, on: :create
  validates :password, presence: true, if: :password_required?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def password_required?
    new_record? || password.present?
  end
end
