class CreateAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :areas do |t|
      t.string :descricao
      t.string :icone      # Adicionando campo icone
      t.timestamps
    end
  end
end
