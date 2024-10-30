class AddDisponibilidadeToAgendamentos < ActiveRecord::Migration[7.1]
  def change
    add_column :agendamentos, :disponibilidade_id, :integer
  end
end
