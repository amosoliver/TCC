class DisponibilidadeConsultor < ApplicationRecord
  belongs_to :consultor, class_name: 'User', foreign_key: 'consultor_id'
end
