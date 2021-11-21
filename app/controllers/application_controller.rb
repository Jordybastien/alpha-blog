class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # TODO: Build Auth methods
  protect_from_forgery with: :exception

  # TODO: Methods created within application_controller are 
  # available in all controllers but not views in order to make them 
  # available to views we need to add them to the helper_methods
  
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    #TODO: !! converts the current_user to a boolean
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
