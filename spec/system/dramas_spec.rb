require 'rails_helper'

RSpec.describe "Dramas", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "ドラマのCRUD操作" do
    it "ドラマを新規登録できること" do
      visit new_drama_path

      fill_in "drama[title]", with: "テストドラマ"
      select "恋愛", from: "drama[genre]"
      fill_in "drama[description]", with: "これはテスト用のドラマです"
      select "感動", from: "drama[mood]"
      fill_in "drama[scene]", with: "夜に見たい"
      find("input[name='drama[watched_on]']").set("2025-11-20")
      check "drama[is_public]"
      click_button "保存"

      aggregate_failures do
        expect(page).to have_content "ドラマを登録しました"
        expect(page).to have_content "テストドラマ"
        expect(page).to have_content "視聴日： 2025年11月20日"
        expect(current_path).to eq(drama_path(Drama.last))
      end
    end

    it "ドラマの一覧ページに登録済みドラマが表示されること" do
      create(:drama, title: "表示テスト", user: user)
      visit dramas_path
      expect(page).to have_content "表示テスト"
    end

    it "ドラマの詳細ページが表示されること" do
      drama = create(:drama, title: "詳細テスト", user: user)
      visit drama_path(drama)

      aggregate_failures do
        expect(page).to have_content "詳細テスト"
        expect(page).to have_content drama.genre
      end
    end

    it "ドラマを編集できること" do
      drama = create(:drama, title: "編集前ドラマ", user: user)
      visit edit_drama_path(drama)
      fill_in "drama[title]", with: "編集後ドラマ"
      click_button "保存"

      aggregate_failures do
        expect(page).to have_content "ドラマを更新しました"
        expect(page).to have_content "編集後ドラマ"
      end
    end

    it "ドラマを削除できること" do
      drama = create(:drama, title: "削除テスト", user: user)
      visit dramas_path(drama)
      page.driver.submit :delete, drama_path(drama), {}

      aggregate_failures do
        expect(page).to have_content "ドラマを削除しました"
        expect(page).not_to have_content "削除テスト"
      end
    end
  end

  describe "ログインしていない場合" do
    it "新規登録ページにアクセスするとログインページにリダイレクトされること" do
      sign_out user
      visit new_drama_path

      aggregate_failures do
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content "ログイン"
      end
    end
  end
end
