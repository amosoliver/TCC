class AddIconeToEspecialidades < ActiveRecord::Migration[7.1]
  def change
    add_column :especialidades, :icone, :string
  end
end
