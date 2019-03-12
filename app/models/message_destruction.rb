class MessageDestruction < ActiveRecord::Base
  has_one :message

  METHOD_NUMBER_OF_HOURS = 'number_of_hours'
  METHOD_NUMBER_OF_LINK = 'number_of_link'

  enum destruction_method: { number_of_link: METHOD_NUMBER_OF_LINK, number_of_hours: METHOD_NUMBER_OF_HOURS }

  validates :destruction_method, :value, presence: true
  validates :destruction_method, inclusion: { in: destruction_methods.keys }
end