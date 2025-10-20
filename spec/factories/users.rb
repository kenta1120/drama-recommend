FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    name { "テストユーザー" }
    introduction { "テスト用のユーザーです。" }
  end
end
