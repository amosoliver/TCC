# Use uma imagem base oficial do Ruby
FROM ruby:3.1

# Instala as dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

# Define o diretório de trabalho
WORKDIR /app

# Copia o Gemfile e o Gemfile.lock
COPY Gemfile* ./

# Instala as gems
RUN bundle install

# Copia o restante do código
COPY . .

# Expõe a porta da aplicação
EXPOSE 3000

# Comando para iniciar a aplicação e executar as migrações
CMD ["sh", "-c", "bundle exec rake db:migrate && rails server -b 0.0.0.0"]
