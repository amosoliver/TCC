class CreateCidades < ActiveRecord::Migration[7.1]
  def change
    create_table :cidades do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
