class PagesController < ApplicationController
  
  def home
    # TODO: Redirect to articles path if logged in
    redirect_to articles_path if logged_in?
  end
  
  def about
    
  end
  
end