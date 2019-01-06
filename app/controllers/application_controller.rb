class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :require_admin
  
  def current_user
    
  end
  
  def require_admin
    unless current_user && current_user.admin?
      render file: 'public/404', status: 404
    end
  end
end
