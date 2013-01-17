class Message < ActiveRecord::Base
  attr_accessible :message_text, :user
  belongs_to :user
end
