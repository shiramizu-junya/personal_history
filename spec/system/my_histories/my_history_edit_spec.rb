require "rails_helper"

RSpec.describe "MyHistory#new", type: :system do
  let(:user) { create(:user, birthday: nil, gender: nil) }
  let(:other_my_history) { create(:my_history, status: :published) }

  describe "自分史編集ページ" do
    context "ログイン後" do
      before { login_as(user) }
      let(:my_history) do
        ->(title_flag = false, my_history_flag = false) { my_history_as(title_flag, my_history_flag) }
      end

      context "正常系" do
        it "タイトルが編集できること" do
          my_history.call(true, true)
          visit(edit_my_history_path(user.my_history.uuid))
          click_button("タイトル編集")
          fill_in("title", with: "メインタイトル編集")
          click_button("更新")
          expect(page).to have_content("メインタイトル編集")
        end

        it "出来事が追加できること" do
          my_history.call(true, true)
          visit(edit_my_history_path(user.my_history.uuid))
          click_button("出来事追加")
          fill_in("age",	with: "15")
          fill_in("happiness",	with: "100")
          fill_in("title",	with: "追加サブタイトル")
          fill_in("episode",	with: "追加エピソード")
          click_button("追加")
          expect(page).to have_content("「15歳」の出来事")
          expect(page).to have_content("100%")
          expect(page).to have_content("追加サブタイトル")
          expect(page).to have_content("追加エピソード")
        end

        it "出来事が編集できること" do
          my_history.call(true, true)
          visit(edit_my_history_path(user.my_history.uuid))
          within ".timeline-card" do
            click_button("編集")
          end
          expect(page).to have_content("10")
          expect(page).to have_content("50")
          expect(page).to have_content("サブタイトル")
          expect(page).to have_content("エピソード")
          fill_in("age", with: "15")
          fill_in("happiness", with: "100")
          fill_in("title", with: "サブタイトル編集")
          fill_in("episode", with: "エピソード編集")
          click_button("更新")
          expect(page).to have_no_content("「10歳」の出来事")
          expect(page).to have_content("「15歳」の出来事")
          expect(page).to have_content("100%")
          expect(page).to have_content("サブタイトル編集")
          expect(page).to have_content("エピソード編集")
        end

        it "出来事を削除できること" do
          my_history.call(true, true)
          visit(edit_my_history_path(user.my_history.uuid))
          click_button("削除")
          page.driver.browser.switch_to.alert.text.should == "本当に削除してよろしいですか?"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_no_content("「10歳」の出来事")
        end

        it "公開設定を選択すると、自分史詳細ページに遷移すること" do
          my_history.call(true, true)
          visit(edit_my_history_path(user.my_history.uuid))
          choose("非公開")
          click_button("自分史更新")
          sleep(0.1)
          visit(my_histories_path)
          expect(page).to have_content("自分史はありません。")
        end

        it "他人の自分史編集ページにアクセスできないこと" do
          other_my_history
          my_history.call(true, true)
          visit(edit_my_history_path(other_my_history.uuid))
          expect(page).to have_content(user.my_history.title)
        end
      end
    end
  end
end
