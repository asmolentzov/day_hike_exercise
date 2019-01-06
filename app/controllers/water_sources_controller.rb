class WaterSourcesController < ApplicationController
  def index
    @trail = Trail.find(params[:trail_id])
  end
  
  def show
    @water_source = WaterSource.find(params[:id])
  end
end