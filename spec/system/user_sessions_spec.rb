require "rails_helper"

RSpec.describe "UserSessions", type: :system do
  describe "ログインページ" do
    context "正常系" do
      it "フォームに正しく入力すると、ログインできること" do
        user = create(:user)
        visit(root_path)
        click_link("ログイン")
        expect(current_path).to eq(login_path)
        fill_in("メールアドレス", with: user.email)
        fill_in("パスワード",	with: "password")
        click_button("ログイン")
        expect(current_path).to eq(my_histories_path)
      end
    end

    context "異常系" do
      it "フォームが未入力の場合、ログインできないこと" do
        user = create(:user)
        visit(login_path)
        click_button("ログイン")
        expect(page).to have_content("ログインに失敗しました。")
      end
    end
  end
end
