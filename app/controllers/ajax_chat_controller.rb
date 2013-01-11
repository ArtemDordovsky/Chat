class AjaxChatController < ApplicationController
  before_filter :authenticate, :only => :index
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(:message_text => params[:message][:message_text], :user => current_user)
    if @message.save
      @messages = Message.all
    end
  end

  def messages
    @messages = Message.all
  end
end
