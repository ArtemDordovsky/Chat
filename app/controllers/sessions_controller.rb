class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      cookies[:last_update] = Marshal.dump(Message.last.id) if Message.last
      redirect_to :chat_rooms, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    ActiveRecord::SessionStore::Session.delete(current_user)
    redirect_to root_url, :notice => "Logged out!"
  end
end
