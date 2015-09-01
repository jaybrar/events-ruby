class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :attendees, dependent: :destroy
  has_many :resources, dependent: :destroy
  has_many :messages
  has_many :events_attended, through: :attendees, source: :event
  validates :first_name, :last_name, :email, :state, :location, :group, :address, presence: true
  validates :email, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :state, length: {maximum: 2}
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?

  before_save do 
    self.email.downcase!
    self.first_name.capitalize!
    self.last_name.capitalize!
    self.group.capitalize!
    self.location.capitalize!
  end

  def full_address
    self.address + " " + self.location + " " + self.state
  end

end
