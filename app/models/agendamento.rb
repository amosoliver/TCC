class Agendamento < ApplicationRecord
  belongs_to :cliente
  belongs_to :consultor
end
