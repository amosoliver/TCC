# db/seeds.rb

# Criando Cidades
cidades = [
  { descricao: 'Cidade A' },
  { descricao: 'Cidade B' },
  { descricao: 'Cidade C' }
]

# Criação das cidades com tratamento de erros
cidades_records = Cidade.create(cidades)
cidades_records.each do |cidade|
  unless cidade.persisted?
    puts "Erro ao criar cidade: #{cidade.errors.full_messages.join(", ")}"
  end
end

# Criando Áreas
areas = [
  { descricao: 'Área de Saúde' },
  { descricao: 'Área de Tecnologia' },
  { descricao: 'Área de Educação' }
]

# Criação das áreas com tratamento de erros
areas_records = Area.create(areas)
areas_records.each do |area|
  unless area.persisted?
    puts "Erro ao criar área: #{area.errors.full_messages.join(", ")}"
  end
end

# Criando Especialidades
especialidades = [
  { descricao: 'Cardiologia', area_id: areas_records[0].id },
  { descricao: 'Pediatria', area_id: areas_records[0].id },
  { descricao: 'Desenvolvimento Web', area_id: areas_records[1].id },
  { descricao: 'Ensino de Matemática', area_id: areas_records[2].id }
]

# Criação das especialidades com tratamento de erros
especialidades_records = Especialidade.create(especialidades)
especialidades_records.each do |especialidade|
  unless especialidade.persisted?
    puts "Erro ao criar especialidade: #{especialidade.errors.full_messages.join(", ")}"
  end
end

# Criando Users (Clientes e Consultores)
users = [
  { email: 'cliente1@example.com', nome: 'Cliente 1', password: 'password', consultor: false, cidade_id: cidades_records.find { |cidade| cidade.descricao == 'Cidade A' }.id },
  { email: 'consultor1@example.com',nome: 'Consultor 2', password: 'password', consultor: true, especialidade_id: especialidades_records.find { |esp| esp.descricao == 'Cardiologia' }.id, cidade_id: cidades_records.find { |cidade| cidade.descricao == 'Cidade A' }.id },
  { email: 'consultor2@example.com',nome: 'Consultor 1', password: 'password', consultor: true, especialidade_id: especialidades_records.find { |esp| esp.descricao == 'Pediatria' }.id, cidade_id: cidades_records.find { |cidade| cidade.descricao == 'Cidade B' }.id },
]

# Criação dos usuários com tratamento de erros
users_records = User.create(users)
users_records.each do |user|
  unless user.persisted?
    puts "Erro ao criar usuário: #{user.errors.full_messages.join(", ")}"
  end
end

# Criando Disponibilidade dos Consultores
disponibilidade = [
  { consultor_id: User.find_by(email: 'consultor1@example.com')&.id, data: Date.today, hora_inicio: '09:00:00', hora_fim: '17:00:00' },
  { consultor_id: User.find_by(email: 'consultor2@example.com')&.id, data: Date.today, hora_inicio: '10:00:00', hora_fim: '18:00:00' }
]

# Criação da disponibilidade com tratamento de erros
disponibilidade_records = DisponibilidadeConsultor.create(disponibilidade)
disponibilidade_records.each do |disponibilidade|
  unless disponibilidade.persisted?
    puts "Erro ao criar disponibilidade: #{disponibilidade.errors.full_messages.join(", ")}"
  end
end

# Criando Agendamentos
agendamentos = [
  { cliente_id: User.find_by(email: 'cliente1@example.com')&.id, consultor_id: User.find_by(email: 'consultor1@example.com')&.id, data: Date.today, hora_inicio: '10:00:00', hora_fim: '11:00:00' },
  { cliente_id: User.find_by(email: 'cliente1@example.com')&.id, consultor_id: User.find_by(email: 'consultor2@example.com')&.id, data: Date.today, hora_inicio: '15:00:00', hora_fim: '16:00:00' }
]

# Criação dos agendamentos com tratamento de erros
agendamentos_records = Agendamento.create(agendamentos)
agendamentos_records.each do |agendamento|
  unless agendamento.persisted?
    puts "Erro ao criar agendamento: #{agendamento.errors.full_messages.join(", ")}"
  end
end

puts "Dados de exemplo foram inseridos com sucesso!"
