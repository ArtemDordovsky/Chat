class Ajax::ChatsController < ApplicationController
  include TrackLastVisit
  before_filter :authenticate

  def show
  end
end
