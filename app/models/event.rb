class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :attendees, dependent: :destroy
  has_many :users_attended, through: :attendees, source: :user
  validates :name, :location, :state, :date, :user_id, presence: true
  validates :name, length: { minimum: 6}
  validates :state, length: {maximum: 2}

  validate :event_date

  def event_date
    errors.add(:event_date, "can't be in the past") if
      date.present? && date < Date.today
  end

end
