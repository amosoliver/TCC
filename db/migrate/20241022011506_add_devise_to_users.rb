class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      # t.string :email,              null: false, default: ""  # Esta coluna já existe
      # t.string :encrypted_password, null: false, default: ""  # Esta coluna já existe

      ## Recoverable
      # t.string   :reset_password_token # Esta coluna já existe
      # t.datetime :reset_password_sent_at # Esta coluna já existe

      ## Rememberable
      # t.datetime :remember_created_at # Esta coluna já existe

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    # As colunas já existem, não adicione os índices novamente.
    # add_index :users, :email,                unique: true
    # add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end

  def self.down
    # Por padrão, não queremos fazer nenhuma suposição sobre como reverter uma migração quando seu
    # modelo já existia. Edite abaixo quais campos você gostaria de remover nesta migração.
    raise ActiveRecord::IrreversibleMigration
  end
end
