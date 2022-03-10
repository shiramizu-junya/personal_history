require "rails_helper"

RSpec.describe "Profile#edit", type: :system do
  let(:user) { create(:user, birthday: nil, gender: nil) }

  describe "プロフィール編集" do
    before { login_as(user) }

    context "正常系" do
      it "ログアウトできること" do
        click_link("ログアウト")
        expect(page).to have_content("ログアウトしました。")
      end
    end
  end
end
