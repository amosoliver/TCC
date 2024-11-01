class AddForeignKeyToAgendamentos < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :agendamentos, :disponibilidade_consultors, column: :disponibilidade_id
  end
end
