class Drama < ApplicationRecord
  validates :title, presence: true
  belongs_to :user

  GENRES = %w[コメディ 恋愛 アクション ファンタジー ホラー サスペンス].freeze
  MOODS = %w[癒し 感動 怖い ドキドキ 胸キュン].freeze

  # タイトル検索
  scope :title_search, ->(title) {
    where("title LIKE ?", "%#{title}%") if title.present?
  }

  # ジャンル検索
  scope :genre_search, ->(genre) {
    where(genre: genre) if genre.present?
  }

  # 感情タグ検索
  scope :mood_search, ->(mood) {
    where("mood LIKE ?", "%#{mood}%") if mood.present?
  }

  # 視聴日検索
  scope :watched_on_search, ->(watched_on) {
    where("to_char(watched_on, 'YYYY-MM-DD') LIKE ?", "#{watched_on}%") if watched_on.present?
  }

  # 公開のみ
  scope :public_dramas, -> { where(is_public: true) }

  # 非公開のみ
  scope :private_dramas, -> { where(is_public: false) }
end
