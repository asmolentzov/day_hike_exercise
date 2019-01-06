class Admin::TrailsController < ApplicationController
  before_action :require_admin
  
  def show
    @trail = Trail.find(params[:id])
  end
  
  def edit
    
  end
end