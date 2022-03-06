require "rails_helper"

RSpec.describe "Profile#edit", type: :system do
  describe "プロフィール編集ページ" do
    context "ログイン前" do
      context "正常系" do
        it "ページにアクセスできないこと" do
          visit(edit_profile_path)
          expect(page).to have_content("ログインしてください。")
        end
      end
    end
  end
end
