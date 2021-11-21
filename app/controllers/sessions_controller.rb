class SessionsController < ApplicationController
  # TODO: Will render new view view within sessions controller
  def new
    
  end
  
  def create
    # TODO: Authentication
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end
  
  def destroy
    # TODO: Logout 1. Clear session 2. Redirect to root_path
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    # TODO: root_path index page
    redirect_to root_path
  end
  
end