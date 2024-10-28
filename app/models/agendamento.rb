class Agendamento < ApplicationRecord
  belongs_to :cliente, class_name: 'User', foreign_key: 'cliente_id'
  belongs_to :consultor, class_name: 'User', foreign_key: 'consultor_id'
end
