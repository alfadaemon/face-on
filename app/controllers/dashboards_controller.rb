class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]

  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboard = 0
    @criminals = Criminal.take(12)
    #@criminals = Criminal.where("genero = '0'")
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
    @match_search = Criminal.find(params[:id])

    @criminals = Criminal.all(:limit=>10)
  end

  def filtro
    
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dashboard }
      else
        format.html { render action: 'new' }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
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
