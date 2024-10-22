json.extract! user, :id, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :consultor, :especialidade_id, :cidade_id, :created_at, :updated_at
json.url user_url(user, format: :json)
