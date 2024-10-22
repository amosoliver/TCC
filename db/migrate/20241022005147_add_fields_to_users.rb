class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :especialidade, null: false, foreign_key: true
    add_column :users, :consultor, :boolean
    add_reference :users, :cidade, null: false, foreign_key: true
  end
end
