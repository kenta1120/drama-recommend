require 'rails_helper'

RSpec.describe "Dramas", type: :request do
  let(:user) { create(:user) }
  let!(:drama) { create(:drama, user: user) }

  describe "GET /index" do
    it "ログインしてないとき、正常にレスポンスを返すこと" do
      get dramas_path
      expect(response).to have_http_status(:ok)
    end

    it "ログイン中、正常にレスポンスを返すこと" do
      sign_in user
      get dramas_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show" do
    it "詳細ページが表示されること" do
      get drama_path(drama)
      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(drama.title)
      end
    end
  end

  describe "POST /create" do
    context "when user is logged in" do
      before { sign_in user }

      it "ドラマを作成できること" do
        expect do
          post dramas_path, params: { drama: { title: "新しいドラマ", genre: "恋愛", is_public: true } }
        end.to change(Drama, :count).by(1)
        expect(response).to redirect_to(drama_path(Drama.last))
      end
    end

    context "when user is not logged in" do
      it "ログインページにリダイレクトされること" do
        post dramas_path, params: { drama: { title: "未ログイン作成" } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
