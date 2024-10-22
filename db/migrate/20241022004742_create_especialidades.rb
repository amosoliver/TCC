class CreateEspecialidades < ActiveRecord::Migration[7.1]
  def change
    create_table :especialidades do |t|
      t.string :descricao
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
