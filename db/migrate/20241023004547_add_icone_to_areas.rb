class AddIconeToAreas < ActiveRecord::Migration[7.1]
  def change
    add_column :areas, :icone, :string
  end
end
