class AjaxChatController < ApplicationController
  before_filter :authenticate, :only => [:index, :new, :create]
  before_filter :messages_all, :only => [:index, :messages]

  def index
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(:message_text => params[:message][:message_text], :user => current_user)
    if @message.save
      messages_all
    end
  end

  def messages
  end

  private
  def messages_all
    @messages = Message.limit(5).all
  end

end
