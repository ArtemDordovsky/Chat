class Ajax::MessagesController < ApplicationController
  before_filter :authenticate
  before_filter :messages_all, :only => [:index, :messages]
  after_filter :last_update, :only => [:index, :messages]

  def index
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(:message_text => params[:message][:message_text], :user => current_user)
    if @message.save
      messages
    end
  end

  def messages
  end

  private
  def messages_all
    if compare_last_message_and_last_update?
      @messages = Message.where('id > ?', cookies[:last_update])
    else
      @messages = []
    end
  end

  def last_update
    message_last = Message.last.id
    if compare_last_message_and_last_update?
      cookies[:last_update] = message_last
    end
  end

  def compare_last_message_and_last_update?
    message_last_create = Message.last.id
    if message_last_create and cookies[:last_update]
      message_last_create > cookies[:last_update].to_i
    end
  end
end
