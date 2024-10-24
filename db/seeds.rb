# db/seeds.rb

# Limpa as tabelas para evitar duplicatas
Agendamento.destroy_all
DisponibilidadeConsultor.destroy_all
Especialidade.destroy_all
User.destroy_all
Area.destroy_all
Cidade.destroy_all

# Criando algumas cidades
cidades = %w[
  São\ Paulo
  Rio\ de\ Janeiro
  Belo\ Horizonte
  Porto\ Alegre
  Curitiba
  Salvador
  Recife
  Fortaleza
  Brasília
  Campinas
]

cidades.each do |cidade_nome|
  Cidade.create!(descricao: cidade_nome)
end

# Criando algumas áreas
areas = [
  { nome: "Tecnologia", descricao: "Área focada em inovação e tecnologia", icone: "tech_icon.png" },
  { nome: "Saúde", descricao: "Área dedicada à saúde e bem-estar", icone: "health_icon.png" },
  { nome: "Educação", descricao: "Área de ensino e aprendizado", icone: "education_icon.png" },
  { nome: "Negócios", descricao: "Área de negócios e empreendedorismo", icone: "business_icon.png" },
  { nome: "Arte", descricao: "Área de expressão artística", icone: "art_icon.png" }
]

areas.each do |area|
  Area.create!(area)
end

# Criando especialidades com relação às áreas
especialidades = [
  { nome: "Desenvolvimento Web", descricao: "Criação de sites e aplicações web", area_id: Area.find_by(nome: "Tecnologia").id, icone: "web_icon.png" },
  { nome: "Psicologia", descricao: "Atendimento psicológico", area_id: Area.find_by(nome: "Saúde").id, icone: "psychology_icon.png" },
  { nome: "Matemática", descricao: "Ensino de Matemática", area_id: Area.find_by(nome: "Educação").id, icone: "math_icon.png" },
  { nome: "Marketing Digital", descricao: "Estratégias de marketing online", area_id: Area.find_by(nome: "Negócios").id, icone: "marketing_icon.png" },
  { nome: "Pintura", descricao: "Técnicas de pintura", area_id: Area.find_by(nome: "Arte").id, icone: "painting_icon.png" }
]

especialidades.each do |especialidade|
  Especialidade.create!(especialidade)
end

# Criando alguns usuários (consultores e clientes)
usuarios = [
  { email: "cliente1@example.com", password: "password", consultor: false, especialidade_id: nil, cidade_id: Cidade.find_by(descricao: "São Paulo").id, nome: "João Silva", descricao: "Cliente de teste 1", foto: "cliente1.png" },
  { email: "cliente2@example.com", password: "password", consultor: false, especialidade_id: nil, cidade_id: Cidade.find_by(descricao: "Rio de Janeiro").id, nome: "Maria Oliveira", descricao: "Cliente de teste 2", foto: "cliente2.png" },
  { email: "consultor1@example.com", password: "password", consultor: true, especialidade_id: Especialidade.find_by(nome: "Desenvolvimento Web").id, cidade_id: Cidade.find_by(descricao: "São Paulo").id, nome: "Carlos Pereira", descricao: "Consultor de TI", foto: "consultor1.png" },
  { email: "consultor2@example.com", password: "password", consultor: true, especialidade_id: Especialidade.find_by(nome: "Psicologia").id, cidade_id: Cidade.find_by(descricao: "Belo Horizonte").id, nome: "Ana Souza", descricao: "Psicóloga clínica", foto: "consultor2.png" }
]

usuarios.each do |usuario|
  User.create!(usuario)
end

# Criando agendamentos
agendamentos = [
  { cliente_id: User.find_by(email: "cliente1@example.com").id, consultor_id: User.find_by(email: "consultor1@example.com").id, data: "2024-10-25", hora_inicio: "10:00", hora_fim: "11:00" },
  { cliente_id: User.find_by(email: "cliente2@example.com").id, consultor_id: User.find_by(email: "consultor2@example.com").id, data: "2024-10-26", hora_inicio: "14:00", hora_fim: "15:00" }
]

agendamentos.each do |agendamento|
  Agendamento.create!(agendamento)
end

# Criando disponibilidade de consultores
disponibilidades = [
  { consultor_id: User.find_by(email: "consultor1@example.com").id, data: "2024-10-25", hora_inicio: "09:00", hora_fim: "12:00" },
  { consultor_id: User.find_by(email: "consultor2@example.com").id, data: "2024-10-26", hora_inicio: "13:00", hora_fim: "16:00" }
]

disponibilidades.each do |disponibilidade|
  DisponibilidadeConsultor.create!(disponibilidade)
end

puts "Dados de teste criados com sucesso!"
