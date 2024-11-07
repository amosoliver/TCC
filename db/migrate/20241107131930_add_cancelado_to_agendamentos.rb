class AddCanceladoToAgendamentos < ActiveRecord::Migration[7.1]
  def change
    add_column :agendamentos, :cancelado, :boolean, default: false, null: false
  end
end
