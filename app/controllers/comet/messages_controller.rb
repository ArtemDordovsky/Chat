class Comet::MessagesController < ApplicationController
  def index
    @messages = Message.where('id > ?', Marshal.load(cookies[:last_update]))
    @message = Message.new
  end

  def create
    @message = Message.new(:message_text => params[:message][:message_text], :user => current_user)
    if @message.save
    end
  end
end
