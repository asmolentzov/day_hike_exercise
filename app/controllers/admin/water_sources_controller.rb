class Admin::WaterSourcesController < ApplicationController
  before_action :require_admin
  
  def index
    @trail = Trail.find(params[:trail_id])
  end
  
  def show
    @water_source = WaterSource.find(params[:id])
  end
  
  def edit
    
  end
  
end