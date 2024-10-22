class CreateAgendamentos < ActiveRecord::Migration[7.1]
  def change
    create_table :agendamentos do |t|
      t.references :cliente, foreign_key: { to_table: :users }
      t.references :consultor, foreign_key: { to_table: :users }      
      t.date :data
      t.time :hora_inicio
      t.time :hora_fim
      t.timestamps
    end
  end
end
