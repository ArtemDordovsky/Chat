class Message < ActiveRecord::Base
  attr_accessible :message_text, :user
  belongs_to :user

  scope :latest_posts, lambda{ |last_visit| where('created_at > ?', last_visit) }
end
