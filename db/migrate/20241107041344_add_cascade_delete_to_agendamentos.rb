class AddCascadeDeleteToAgendamentos < ActiveRecord::Migration[6.0]
  def change
    # Remover a chave estrangeira de agendamento_id na tabela disponibilidade_consultors, se necessário
    remove_foreign_key :disponibilidade_consultors, :agendamentos if foreign_key_exists?(:disponibilidade_consultors, :agendamentos)

    # Adicionar a chave estrangeira em agendamentos com exclusão em cascata para disponibilidade_consultor_id
    add_foreign_key :agendamentos, :disponibilidade_consultors, column: :disponibilidade_id, on_delete: :cascade
  end
end
