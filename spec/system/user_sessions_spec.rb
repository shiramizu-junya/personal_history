require "rails_helper"

RSpec.describe "UserSessions", type: :system do
  let!(:user) { create(:user) }

  before do
    # Capybara::ElementNotFound: Unable to find visible link "ログイン"
    # ログアウトのテストで画面がハンバーガーメニューになるためエラーになる対策
    driven_by(:rack_test)
  end

  describe "ログイン前" do
    describe "ログイン画面" do
      context "フォームの入力値が正常なとき" do
        it "ログイン機能が成功すること" do
          visit login_path
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード", with: "password"
          click_button "ログイン"
          expect(page).to have_content "ログインしました。"
          expect(current_path).to eq tracks_path
        end
      end

      context "フォームが未入力のとき" do
        it "ログイン処理が失敗すること" do
          visit login_path
          fill_in "メールアドレス", with: ""
          fill_in "パスワード", with: ""
          click_button "ログイン"
          expect(page).to have_content "ログインに失敗しました。"
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe "ログイン後" do
    context 'ログアウトボタンをクリックする' do
      it 'ログアウト処理が成功すること' do
        login_as(user)
        click_link "ログアウト"
        expect(page).to have_content "ログアウトしました。"
        expect(current_path).to eq root_path
      end
    end
  end
end
