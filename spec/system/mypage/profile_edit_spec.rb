require "rails_helper"

RSpec.describe "Profile#edit", type: :system do
  let(:user) { create(:user, birthday: nil, gender: nil) }

  describe "プロフィール編集" do

    context "ログイン前" do
      context "正常系" do
        it "ページにアクセスできないこと" do
          visit(edit_profile_path)
          expect(page).to have_content("ログインしてください。")
        end
      end
    end

    context "ログイン後" do
      before { login_as(user) }
    let(:my_history) do
      ->(title_flag = false, my_history_flag = false) { my_history_as(title_flag, my_history_flag) }
    end
      context "正常系" do
        it "自分史を作成していない場合は、生年月日と性別が存在しないこと" do
          sleep(5)
          find(".navbar-link").hover
          click_link("プロフィール編集")
          expect(page).to have_field("ユーザー名", with: user.name)
          expect(page).to have_field("メールアドレス", with: user.email)
          expect(page).to have_select("性別", selected: "選択してください")
        end

        it "フォームに適切に入力した場合、更新できること" do
          visit(edit_profile_path)
          fill_in("ユーザー名", with: "user_編集")
          fill_in("メールアドレス", with: "sample_50@example.com")
          fill_in("生年月日", with: Date.current.ago(30.years).strftime("00%Y-%m-%d"))
          select("女性", from: "性別")
          click_button("更新")
          expect(current_path).to eq(profile_path)
          expect(page).to have_content("user_編集")
          expect(page).to have_content("sample_50@example.com")
          expect(page).to have_content(Date.current.ago(30.years).strftime("%Y/%m/%d"))
          expect(page).to have_content("女性")
        end
      end

      context "異常系" do
        it "生年月日と性別が未入力の場合、エラーになること" do
          visit(edit_profile_path)
          click_button("更新")
          expect(page).to have_content("生年月日を入力してください")
          expect(page).to have_content("性別を選択してください")
        end

        it "生年月日が未来の場合、エラーメッセージが表示されること" do
          visit(edit_profile_path)
          fill_in("生年月日", with: Date.current.tomorrow.strftime("00%Y-%m-%d"))
          click_button("更新")
          expect(page).to have_content("生年月日は未来の日付を入力できません")
        end

        it "生年月日が100歳より大きい場合、エラーメッセージが表示されること" do
          visit(edit_profile_path)
          fill_in("生年月日", with: Date.current.ago(101.years).strftime("00%Y-%m-%d"))
          click_button("更新")
          expect(page).to have_content("生年月日は0歳以上100歳以下で選択してください")
        end
      end
    end
  end
end
