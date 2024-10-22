json.extract! agendamento, :id, :cliente_id, :consultor_id, :data, :hora_inicio, :hora_fim, :created_at, :updated_at
json.url agendamento_url(agendamento, format: :json)
