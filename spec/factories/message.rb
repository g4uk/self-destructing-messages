FactoryBot.define do
  factory :message do
    id { SecureRandom.hex(15) }
    message { 'Test' }
    number_of_link { 0 }
    destructed { false }
    created_at { Time.now }
  end
end