FactoryBot.define do
  factory :message_destruction do
    message
    destruction_method { 'number_of_link' }
    value { 1 }
  end
end