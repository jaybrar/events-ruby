class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :attendees, dependent: :destroy
  has_many :events_attended, through: :attendees, source: :event
  validates :first_name, :last_name, :email, :state, :location, presence: true
  validates :email, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :state, length: {maximum: 2}

  before_save do
    self.email.downcase!
  end

  before_save do 
    self.first_name.capitalize!
    self.last_name.capitalize!
  end

end
