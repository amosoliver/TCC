class ConsultorController < ApplicationController
  def index
    @consultores = Users.all
  end

  def show
    # lógica para exibir um consultor específico
  end

  def new
    # lógica para mostrar o formulário de novo consultor
  end

  def create
    # lógica para criar um novo consultor
  end

  def edit
    # lógica para mostrar o formulário de edição
  end

  def update
    # lógica para atualizar um consultor existente
  end

  def destroy
    # lógica para excluir um consultor
  end
end
