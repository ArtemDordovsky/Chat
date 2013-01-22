class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private
  def current_user
    session = ActiveRecord::SessionStore::Session.select(:data).where('session_id = ?', cookies[:_session_id]).last
    @current_user = User.find(session.data["user_id"]) if session
  end

  helper_method :current_user

  def authenticate
    logged_in? || access_denied
  end

  def logged_in?
    current_user.is_a? User
  end

  helper_method :logged_in?

  def access_denied
    redirect_to :log_in
  end

end
