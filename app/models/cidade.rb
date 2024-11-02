class Cidade < ApplicationRecord
  has_many :consultores, class_name: "User", foreign_key: "cidade_id"
  has_many :clientes, class_name: "User", foreign_key: "cidade_id"
end
