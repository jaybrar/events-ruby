class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :attendees, dependent: :destroy
  has_many :users_attended, through: :attendees, source: :user
  validates :name, :location, :state, :date, :user_id, :address, presence: true
  validates :name, length: { minimum: 6}
  validates :state, length: {maximum: 2}
  validate :event_date

  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?

  def event_date
    errors.add(:event_date, "can't be in the past") if
      date.present? && date < Date.today
  end

  def full_address
    self.address + " " + self.location + " " + self.state
  end

end
