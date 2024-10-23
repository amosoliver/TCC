class CreateEspecialidades < ActiveRecord::Migration[7.1]
  def change
    create_table :especialidades do |t|
      t.string :nome
      t.string :descricao
      t.references :area, null: false, foreign_key: true
      t.string :icone      # Adicionando campo icone
      t.timestamps
    end
  end
end
