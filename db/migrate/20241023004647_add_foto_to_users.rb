class AddFotoToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :foto, :string
  end
end
