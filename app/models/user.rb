class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    user = find_by_email(email)
    user if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.users_online
    find(users) if users

  end

  def self.users
    sessions = ActiveRecord::SessionStore::Session.select([:data, :updated_at]).all
    users_ids = sessions.inject([]) do |result, session|
      result << session.data["user_id"] if session
    end
  end

end
