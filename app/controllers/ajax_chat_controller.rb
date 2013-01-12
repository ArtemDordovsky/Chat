class AjaxChatController < ApplicationController
  before_filter :authenticate, :only => :index
  before_filter :whos_online
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

  def users_online
    @users = User.all
  end

  def messages_all
    @messages = Message.all
  end

end
