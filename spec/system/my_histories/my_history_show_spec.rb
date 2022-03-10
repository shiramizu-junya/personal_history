require "rails_helper"

RSpec.describe "MyHistory#show", type: :system do
  describe "自分史詳細ページ" do
    context "ログイン前" do
      context "正常系" do
        it "出来事が存在しない場合は、出来事はありませんと表示されていること" do
          my_history = create(:my_history, status: :published)
          visit(my_history_path(my_history.uuid))
          expect(page).to have_content("出来事はありません。")
        end

        it "コメントが存在しない場合は、コメントはありませんと表示されていること" do
          my_history = create(:my_history, status: :published)
          visit(my_history_path(my_history.uuid))
          expect(page).to have_content("コメントはありません")
        end

        it "出来事が存在する場合は、出来事が表示されること" do
          my_history = create(:my_history, status: :published)
          event = create(:event, my_history: my_history)
          visit(my_history_path(my_history.uuid))
          expect(page).to have_content(event.age)
          expect(page).to have_content(event.title)
          expect(page).to have_content(event.episode)
          expect(page).to have_content(event.happiness)
        end

        it "コメントといいねができないこと" do
          my_history = create(:my_history, status: :published)
          visit(my_history_path(my_history.uuid))
          expect(page).to have_no_content("投稿")
          expect(page).to have_no_content("いいね")
        end

        it "Twitter共有リンクが表示されていること" do
          my_history = create(:my_history, status: :published)
          visit(my_history_path(my_history.uuid))
          expect(page).to have_content("ツイート")
        end
      end
    end

    context "ログイン後" do
      let(:user) { create(:user, birthday: nil, gender: nil) }
      before { login_as(user) }
      let(:my_history) do
        ->(title_flag = false, my_history_flag = false) { my_history_as(title_flag, my_history_flag) }
      end

      context "正常系" do
        it "コメントができること" do
          my_history.call(true, true)
          visit(my_history_path(user.my_history.uuid))
          fill_in("js-new-comment-body", with: "コメントしました")
          click_button("投稿")
          expect(page).to have_content("コメントしました")
        end

        it "いいねができること" do
          my_history.call(true, true)
          visit(my_history_path(user.my_history.uuid))
          click_link("js-like-button-#{user.my_history.id}")
          expect(page).to have_css(".unlike-btn")
        end

        it "コメントが編集できること" do
          my_history.call(true, true)
          visit(my_history_path(user.my_history.uuid))
          fill_in("js-new-comment-body", with: "コメントしました")
          click_button("投稿")
          find("#js-comment-edit-icon").click
          within ".dropdown-content" do
            page.first(".js-edit-comment-button").click
          end
          fill_in("js-textarea-comment-#{user.comments[0].id}", with: "コメント")
          click_button("更新")
          expect(page).to have_content("コメント")
        end

        it "コメントが削除できること" do
          my_history.call(true, true)
          visit(my_history_path(user.my_history.uuid))
          fill_in("js-new-comment-body", with: "コメントしました")
          click_button("投稿")
          find("#js-comment-edit-icon").click
          click_link("削除")
          page.driver.browser.switch_to.alert.text.should == "コメントを削除しますか？"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_no_content("コメントしました")
        end

        it "ダウンロードボタンが表示されていること" do
          my_history.call(true, true)
          visit(my_history_path(user.my_history.uuid))
          expect(page).to have_button("ダウンロード")
        end

        it "編集ボタンをクリックすると、編集画面に遷移すること" do
          my_history.call(true, true)
          visit(my_history_path(user.my_history.uuid))
          within ".show-page-edit-link" do
            click_link("編集")
          end
          expect(current_path).to eq(edit_my_history_path(user.my_history.uuid))
        end

      end

      context "異常系" do
        it "コメントを500文字より多く入力した場合、エラーになること" do
          my_history.call(true, true)
          visit(my_history_path(user.my_history.uuid))
          fill_in("js-new-comment-body", with: "あ" * 501)
          click_button("投稿")
          expect(page).to have_content("コメントは500文字以内で入力してください")
        end
      end
    end
  end
end
