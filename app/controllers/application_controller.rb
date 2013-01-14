class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  # Make current_user available in templates as a helper
  helper_method :current_user

  # Filter method to enforce a login requirement
  # Apply as a before_filter on any controller you want to protect
  def authenticate
    logged_in? || access_denied
  end

  # Predicate method to test for a logged in user    
  def logged_in?
    current_user.is_a? User
  end

  # Make logged_in? available in templates as a helper
  helper_method :logged_in?

  def access_denied
    redirect_to login_path, :notice => "Please log in to continue" and return false
  end

#    def users_online
#      @users_online = User.users_online
#    end

end
