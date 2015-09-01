class Message < ActiveRecord::Base
  belongs_to :user
  validates :receiver_id, :message, presence: true
end
