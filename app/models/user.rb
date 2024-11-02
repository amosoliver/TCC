class User < ApplicationRecord
  # Associações
  belongs_to :especialidade, optional: true
  belongs_to :cidade, optional: true
  has_many :agendamentos, foreign_key: 'cliente_id', class_name: 'Agendamento'
  has_many :disponibilidade_consultors, foreign_key: 'consultor_id', class_name: 'DisponibilidadeConsultor'
  has_many :agendamentos_as_consultor, foreign_key: 'consultor_id', class_name: 'Agendamento'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validações
  validates :email, presence: true
  validates :nome, presence: true
  validates :cidade_id, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :especialidade, presence: true, if: :consultor?

  def consultor?
    consultor == true
  end


  private



  def password_required?
    new_record? || password.present?
  end
end
