FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@site.com" }
    password 'password'
    password_confirmation 'password'
    name 'zaza'
    locale 'en'
    subscribe true
  end
end
