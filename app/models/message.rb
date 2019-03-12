class Message < ActiveRecord::Base
  has_one :message_destruction, dependent: :destroy

  validates :message, presence: true
end