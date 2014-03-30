class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]

  # GET /dashboards
  # GET /dashboards.json
  def index
    @criminals = Criminal.take(12)
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
    @match_search = Criminal.find(params[:id])

    @criminals = Criminal.all(:limit=>10)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @criminal = Criminal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dashboard_params
      params[:criminal]
    end
end
