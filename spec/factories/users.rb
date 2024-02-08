FactoryBot.define do
  factory :user do
    name { "Saba" }
    sequence(:email) { |n| "saba_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
