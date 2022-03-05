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
  end
end
