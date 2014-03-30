class API::V1::CriminalsController < ApplicationController

  def index
    @criminals = Criminal.all
    render :status => 200, :json => @criminals
  end

  def show
    @criminals = Criminal.find(params[:id])
    render :status =>200, :json => @criminals.to_json(:only => [:nombre, :apellido])
  end

  def create
    @criminal = Criminal.new(criminal_params)
    @criminal.nombre = params['nombre'] if params['nombre']
    @criminal.apellido = params['apellido'] if params['apellido']
    @criminal.genero = params['genero'] if params['genero']
    @criminal.ficha = params['ficha'] if params['ficha']
    @criminal.foto = params['criminal']['foto'] if params['criminal']['foto']

    if @criminal.save
      render :status => 200, :json => {:status => "OK"}
    else
      render :status => 300, :json => {:status => "Error guardando perfil criminal"}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_criminal
      @criminal = Criminal.find(params[:id])
    end

    def criminal_params
      params.require(:criminal).permit(:nombre, :apellido, :genero, :ficha, :foto)
    end

end
