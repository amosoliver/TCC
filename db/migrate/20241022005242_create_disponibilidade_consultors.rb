class CreateDisponibilidadeConsultors < ActiveRecord::Migration[7.1]
  def change
    create_table :disponibilidade_consultors do |t|
      t.references :consultor, foreign_key: { to_table: :users }
      t.date :data
      t.time :hora_inicio
      t.time :hora_fim
      t.timestamps
    end
  end
end
