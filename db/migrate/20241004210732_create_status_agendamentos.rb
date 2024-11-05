class CreateStatusAgendamentos < ActiveRecord::Migration[7.1]
  def change
    create_table :status_agendamentos do |t|
      t.string :descricao, null: false
      t.timestamps
    end
  end
end
