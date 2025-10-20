require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "ユーザーが正しく作成できること" do
      expect(build(:user)).to be_valid
    end

    it "メールアドレスが必須であること" do
      expect(build(:user, email: nil)).not_to be_valid
    end

    it "パスワードが必須であること" do
      expect(build(:user, password: nil)).not_to be_valid
    end

    it "メールアドレスが一意であること" do
      create(:user, email: "a@example.com")
      expect(build(:user, email: "a@example.com")).not_to be_valid
    end

    it "名前がなくても有効であること" do
      expect(build(:user, name: nil)).to be_valid
    end

    it "自己紹介がなくても有効であること" do
      expect(build(:user, introduction: nil)).to be_valid
    end
  end

  describe "関連付け" do
    it "ユーザーを削除すると関連するドラマも削除されること" do
      user = create(:user)
      create(:drama, user: user)
      expect { user.destroy }.to change(Drama, :count).by(-1)
    end
  end
end
