# db/seeds.rb

# Criar áreas
areas = Area.create!([
  { nome: 'Saúde', descricao: 'Área de saúde e bem-estar', icone: 'saude.png' },
  { nome: 'Educação', descricao: 'Área de ensino e aprendizagem', icone: 'educacao.png' },
  { nome: 'Tecnologia', descricao: 'Área de tecnologia e inovação', icone: 'tecnologia.png' }
])

# Criar cidades
cidades = Cidade.create!([
  { descricao: 'São Paulo' },
  { descricao: 'Rio de Janeiro' },
  { descricao: 'Belo Horizonte' }
])

# Criar especialidades
especialidades = Especialidade.create!([
  { nome: 'Médico', descricao: 'Profissional de saúde', area_id: areas[0].id, icone: 'medico.png' },
  { nome: 'Professor', descricao: 'Educador em diversas disciplinas', area_id: areas[1].id, icone: 'professor.png' },
  { nome: 'Desenvolvedor', descricao: 'Especialista em desenvolvimento de software', area_id: areas[2].id, icone: 'desenvolvedor.png' }
])

# Criar usuários (consultores)
users = User.create!([
  { email: 'consultor1@example.com', encrypted_password: 'password', consultor: true, especialidade_id: especialidades[0].id, cidade_id: cidades[0].id, nome: 'Consultor 1', descricao: 'Especialista em saúde', foto: 'consultor1.png' },
  { email: 'consultor2@example.com', encrypted_password: 'password', consultor: true, especialidade_id: especialidades[1].id, cidade_id: cidades[1].id, nome: 'Consultor 2', descricao: 'Especialista em educação', foto: 'consultor2.png' },
  { email: 'consultor3@example.com', encrypted_password: 'password', consultor: true, especialidade_id: especialidades[2].id, cidade_id: cidades[2].id, nome: 'Consultor 3', descricao: 'Especialista em tecnologia', foto: 'consultor3.png' }
])

# Criar agendamentos
Agendamento.create!([
  { cliente_id: users[0].id, consultor_id: users[1].id, data: '2024-10-30', hora_inicio: '10:00', hora_fim: '11:00' },
  { cliente_id: users[0].id, consultor_id: users[2].id, data: '2024-10-31', hora_inicio: '14:00', hora_fim: '15:00' }
])

# Criar disponibilidade de consultores
DisponibilidadeConsultor.create!([
  { consultor_id: users[1].id, data: '2024-10-30', hora_inicio: '09:00', hora_fim: '12:00' },
  { consultor_id: users[2].id, data: '2024-10-31', hora_inicio: '13:00', hora_fim: '16:00' }
])

puts "Dados de exemplo criados com sucesso!"
