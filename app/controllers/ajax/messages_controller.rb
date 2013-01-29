class Ajax::MessagesController < ApplicationController
  include TrackLastVisit
  before_filter :authenticate

  def index
    @messages = Message.latest_posts(current_user.updated_at)
  end

  def create
    @message = Message.create(message_text: params[:message][:message_text], user: current_user)
  end
end
