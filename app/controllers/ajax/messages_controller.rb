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
      @messages = Message.where('id > ?', Marshal.load(cookies[:last_update]))
    else
      @messages = []
    end
  end

  def last_update
    if compare_last_message_and_last_update?
      cookies[:last_update] = Marshal.dump(Message.last.id)
    end
  end

  def compare_last_message_and_last_update?
    if Message.last.id and cookies[:last_update]
      Message.last.id > Marshal.load(cookies[:last_update]).to_i
    end
  end
end
