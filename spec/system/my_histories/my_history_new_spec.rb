require "rails_helper"

RSpec.describe "MyHistory#new", type: :system do
  let(:user) { create(:user, birthday: nil, gender: nil) }

  describe "自分史新規作成ページ" do
    context "ログイン前" do
      context "正常系" do
        it "未ログインユーザーはアクセスできないこと" do
          visit(new_my_history_path)
          expect(page).to have_content("ログインしてください。")
        end
      end
    end

    context "ログイン後" do
      before { login_as(user) }

      context "正常系" do
        it "生年月日とタイトルを入力すると、画面に反映されていること" do
          visit(new_my_history_path)
          fill_in("birthday", with: Date.current.ago(20.years).strftime("00%Y-%m-%d"))
          select("男性", from: "gender")
          click_button("更新")
          fill_in("title", with: "メインタイトル")
          click_button("追加")
          expect(page).to have_content("メインタイトル")
          expect(page).to have_content("現在の年齢：20歳")
        end
      end
    end
  end
end
