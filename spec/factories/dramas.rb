FactoryBot.define do
  factory :drama do
    association :user
    sequence(:title) { |n| "ドラマタイトル#{n}" }
    genre { Drama::GENRES.sample }
    mood { Drama::MOODS.sample }
    description { "テスト用感想" }
    scene { "テストシーン" }
    is_public { true }
  end
end
