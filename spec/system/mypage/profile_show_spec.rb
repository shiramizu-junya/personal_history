require "rails_helper"

RSpec.describe "Profile#show", type: :system do
  let(:user) { create(:user, birthday: nil, gender: nil) }

  describe "マイページ" do
    before { login_as(user) }
    let(:my_history) do
      ->(title_flag = false, my_history_flag = false) { my_history_as(title_flag, my_history_flag) }
    end

    context "ログイン後", js: true do
      it "ユーザー名、メールアドレス、退会リンクが表示されていること" do
        sleep(5)
        find(".navbar-link").hover
        click_link("マイページ")
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.email)
        expect(page).to have_content("退会")
      end

      it "自分史を作成済みの場合は、生年月日や性別が存在すること" do
        my_history.call(true, true)
        visit(profile_path)
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.email)
        expect(page).to have_content(user.birthday)
        expect(page).to have_content("男性")
        expect(page).to have_content(user.my_history.title)
        expect(page).to have_content("公開")
      end

      it "自分史のタイトルをクリックすると、詳細ページに遷移すること" do
        my_history.call(true, true)
        visit(profile_path)
        click_link(user.my_history.title)
        expect(current_path).to eq(my_history_path(user.my_history.uuid))
      end

      it "編集リンクをクリックすると、自分史編集ページに遷移すること" do
        my_history.call(true, true)
        visit(profile_path)
        click_link("編集")
        expect(current_path).to eq(edit_my_history_path(user.my_history.uuid))
      end

      it "退会リンクをクリックすると、退会できること" do
        my_history.call(true, true)
        visit(profile_path)
        click_link("退会")
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content("ご利用ありがとうございました。")
        expect(current_path).to eq(root_path)
      end
    end
  end
end
