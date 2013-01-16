class AjaxChatController < ApplicationController
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
      messages_all
    end
  end

  def messages
  end

  private
  def messages_all
    if compare_last_message_and_last_update?
      last_message_time = Time.zone.parse(cookies[:last_update]).utc
      @messages = Message.where('created_at > ?', last_message_time.to_s)
    else
      @messages = []
    end
  end

  def last_update
    message_last_create = Message.select(:created_at).first
    if compare_last_message_and_last_update?
      cookies[:last_update] = message_last_create.created_at
      p cookies[:last_update]
    else
      cookies[:last_update] = Time.now
    end
  end

  def compare_last_message_and_last_update?
    message_last_create = Message.select(:created_at).first
    if message_last_create and cookies[:last_update]
      message_last_create.created_at.to_i > cookies[:last_update].to_time.to_i
    end
  end

end
