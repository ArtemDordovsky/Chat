class Message < ActiveRecord::Base
  attr_accessible :message_text, :user
  belongs_to :user
  default_scope order('created_at DESC limit 5')
end
