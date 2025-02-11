class AreasController < ApplicationController
  before_action :authenticate_user! # Exige autenticação
  before_action :restrict_access_for_consultor, except: [:index, :show] # Restringe se for consultor
  before_action :set_area, only: %i[show edit update destroy]

  # GET /areas or /areas.json
  def index
    @areas = Area.all
  end

  # GET /areas/1 or /areas/1.json
  def show
    @especialidades = Especialidade.where(area_id: @area.id)
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas or /areas.json
  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        format.html { redirect_to @area, notice: "Area was successfully created." }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1 or /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to @area, notice: "Area was successfully updated." }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1 or /areas/1.json
  def destroy
    @area.destroy!

    respond_to do |format|
      format.html { redirect_to areas_path, status: :see_other, notice: "Area was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Restrict access for consultors
    def restrict_access_for_consultor
      if !current_user.consultor
        redirect_to areas_path, alert: "Acesso restrito para consultor"
      end
    end

    # Only allow a list of trusted parameters through.
    def area_params
      params.require(:area).permit(:descricao, :nome)
    end
end
