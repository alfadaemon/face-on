class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]

  # GET /dashboards
  # GET /dashboards.json
  def index
    @criminals = Criminal.take(12)
    #@criminals = Criminal.where("genero = '0'")
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
    @match_search = Criminal.find(params[:id])
    #select the ones that match more close to this
    @criminals = Criminal.all :limit=>12
  end

  # POST /dashboards
  def filtro
    if params['filtro']=='Masculino'
      @criminals = Criminal.where(:genero=>1).take(12)
    elsif params['filtro']=='Femenino'
      @criminals = Criminal.where(:genero=>0).take(12)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
    #  @criminal = Criminal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dashboard_params
      params[:criminal]
    end
end
