require 'rails_helper'

RSpec.describe Drama, type: :model do
  let(:user) { create(:user) }

  describe "バリデーション" do
    it "タイトルがあれば保存できること" do
      drama = build(:drama, title: "テストドラマ", user: user)
      expect(drama).to be_valid
    end

    it "タイトルがなければ保存できないこと" do
      drama = build(:drama, title: nil, user: user)
      expect(drama).not_to be_valid
    end
  end

  describe "定数" do
    it "ジャンル一覧を持っていること" do
      expect(described_class::GENRES).to eq %w[コメディ 恋愛 アクション ファンタジー ホラー サスペンス]
    end

    it "気分一覧を持っていること" do
      expect(described_class::MOODS).to eq %w[癒し 感動 怖い ドキドキ 胸キュン]
    end
  end

  describe "スコープ" do
    let!(:drama_romance) { create(:drama, title: "恋愛ドラマ", genre: "恋愛", mood: "感動", is_public: true, user: user) }
    let!(:drama_horror) { create(:drama, title: "ホラー", genre: "ホラー", mood: "怖い", is_public: false, user: user) }
    let!(:drama_action) { create(:drama, title: "アクションドラマ", genre: "アクション", mood: "ドキドキ", is_public: true, user: user) }

    context "when searching by title" do
      let(:result) { described_class.title_search("恋愛") }

      it "部分一致で検索できること" do
        expect(result).to include(drama_romance)
      end

      it "一致しないものは含まないこと" do
        expect(result).not_to include(drama_horror)
      end
    end

    context "when searching by genre" do
      let(:result) { described_class.genre_search("恋愛") }

      it "ジャンルで検索できること" do
        expect(result).to include(drama_romance)
      end

      it "他のジャンルを含まないこと" do
        expect(result).not_to include(drama_horror, drama_action)
      end
    end

    context "when searching by mood" do
      let(:result) { described_class.mood_search("感動") }

      it "部分一致で検索できること" do
        expect(result).to include(drama_romance)
      end

      it "一致しないものを含まないこと" do
        expect(result).not_to include(drama_horror)
      end
    end
  end

  describe "視聴日スコープ" do
    let(:user) { create(:user) }
    let!(:watched_drama) { create(:drama, title: "視聴済みドラマ", watched_on: Date.new(2025, 11, 20), is_public: false, user: user) }
    let!(:unwatched_drama) { create(:drama, title: "未視聴ドラマ", watched_on: nil, is_public: false, user: user) }

    it "視聴日が一致するものを取得できること" do
      result = described_class.watched_on_search("2025")
      expect(result).to include(watched_drama)
      expect(result).not_to include(unwatched_drama)
    end

    it "一致しない場合は含まれないこと" do
      result = described_class.watched_on_search("2024")
      expect(result).to be_empty
    end
  end

  describe "公開、非公開" do
    let!(:public_drama)  { create(:drama, is_public: true,  user: user) }
    let!(:private_drama) { create(:drama, is_public: false, user: user) }

    it "公開のみを取得できること" do
      expect(described_class.public_dramas).to contain_exactly(public_drama)
    end

    it "非公開のみ取得できること" do
      expect(described_class.private_dramas).to contain_exactly(private_drama)
    end
  end
end
