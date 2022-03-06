require "rails_helper"

RSpec.describe "Profile#show", type: :system do
  describe "プロフィール詳細ページ" do
    context "ログイン前" do
      context "正常系" do
        it "ページにアクセスできないこと" do
          visit(profile_path)
          expect(page).to have_content("ログインしてください。")
        end
      end
    end
  end
end
