require "rails_helper"

RSpec.describe "MyHistory#index", type: :system do
  describe "自分史一覧ページ" do
    context "ログイン前" do
      context "正常系" do
        it "一覧ページにアクセスできること" do
          visit(root_path)
          click_link("自分史一覧")
          expect(current_path).to eq my_histories_path
          expect(page).to have_content "自分史はありません"
          expect(page).to have_content "0件の自分史が見つかりました"
          expect(page).to have_content "0 - 0件 / 0件"
        end

        it "公開されている自分史が表示されていること" do
          create_list(:my_history, 25, status: :published)
          create_list(:my_history, 5, status: :unpublished)
          visit(my_histories_path)
          expect(page).to have_content("20件の自分史が見つかりました")
          expect(page).to have_content("1 - 20件 / 25件")
          expect(page).to have_content("ツイート")
        end

        it "性別検索が正しく動作していること" do
          10.times do
            user = create(:user, gender: :men)
            create(:my_history, user: user, status: :published)
          end
          10.times do
            user = create(:user, gender: :women)
            create(:my_history, user: user, status: :published)
          end
          visit(my_histories_path)
          select("男性", from: "q[user_gender_eq]")
          click_button("検索")
          expect(page).to have_content("10件の自分史が見つかりました")
          expect(page).to have_content("1 - 10件 / 10件")
          select("その他", from: "q[user_gender_eq]")
          click_button("検索")
          expect(page).to have_content("0件の自分史が見つかりました")
          expect(page).to have_content("0 - 0件 / 0件")
          expect(page).to have_content("自分史はありません。")
        end

        it "年齢検索が正しく動作していること" do
          10.times do
            user = create(:user, birthday: Date.current.ago(20.years).strftime("%Y-%m-%d"))
            create(:my_history, user: user, status: :published)
          end
          10.times do
            user = create(:user, birthday: Date.current.ago(30.years).strftime("%Y-%m-%d"))
            create(:my_history, user: user, status: :published)
          end
          visit(my_histories_path)
          fill_in("q_user_birthday_convert_age_gteq", with: "20")
          fill_in("q_user_birthday_convert_age_lteq", with: "25")
          click_button("検索")
          expect(page).to have_content("10件の自分史が見つかりました")
          expect(page).to have_content("1 - 10件 / 10件")
        end

        it "ページネーションが正しく動作していること" do
          create_list(:my_history, 25, status: :published)
          visit(my_histories_path)
          click_link("2")
          expect(page).to have_content("5件の自分史が見つかりました")
          expect(page).to have_content("21 - 25件 / 25件")
        end
      end
    end
  end
end
