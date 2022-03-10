require "rails_helper"

RSpec.describe "MyHistory#new", type: :system do
  let(:user) { create(:user, birthday: nil, gender: nil) }

  describe "自分史新規作成ページ" do
    context "ログイン前" do
      context "正常系" do
        it "未ログインユーザーはアクセスできないこと" do
          visit(new_my_history_path)
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
        it "プロフィールとタイトルを入力すると、画面に反映されていること" do
          visit(new_my_history_path)
          fill_in("birthday", with: Date.current.ago(20.years).strftime("00%Y-%m-%d"))
          select("男性", from: "gender")
          click_button("更新")
          fill_in("title", with: "メインタイトル")
          click_button("追加")
          expect(page).to have_content("メインタイトル")
          expect(page).to have_content("現在の年齢：20歳")
        end

        it "タイトルが編集できること" do
          my_history.call(true)
          click_button("タイトル編集")
          fill_in("title", with: "メインタイトル編集")
          click_button("更新")
          expect(page).to have_content("メインタイトル編集")
        end

        it "出来事が追加できること" do
          my_history.call(true)
          click_button("出来事追加")
          fill_in("age",	with: "10")
          fill_in("happiness",	with: "50")
          fill_in("title",	with: "サブタイトル")
          fill_in("episode",	with: "エピソード")
          click_button("追加")
          expect(page).to have_content("「10歳」の出来事")
          expect(page).to have_content("50%")
          expect(page).to have_content("サブタイトル")
          expect(page).to have_content("エピソード")
        end

        it "出来事を編集できること" do
          my_history.call(true, true)
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
          click_button("削除")
          page.driver.browser.switch_to.alert.text.should == "本当に削除してよろしいですか?"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_no_content("「10歳」の出来事")
        end

        it "公開設定を選択すると、自分史詳細ページに遷移すること" do
          my_history.call(true, true)
          choose("公開")
          click_button("自分史作成")
          sleep(0.1)
          expect(current_path).to eq(my_history_path(user.my_history.uuid))
        end

        it "公開を選択すると、一覧ページに自分史が表示されること" do
          my_history.call(true, true)
          choose("公開")
          click_button("自分史作成")
          visit(my_histories_path)
          expect(page).to have_content(user.name)
          expect(page).to have_content(user.my_history.title)
        end

        it "非公開を選択すると、一覧ページに自分史が表示されないこと" do
          my_history.call(true, true)
          choose("非公開")
          click_button("自分史作成")
          sleep(0.1)
          visit(my_histories_path)
          expect(page).to have_content("自分史はありません。")
        end
      end

      context "異常系" do
        it "生年月日が未入力の場合、エラーメッセージが表示されること" do
          visit(new_my_history_path)
          select("男性", from: "gender")
          click_button("更新")
          expect(page).to have_content("生年月日を入力してください")
        end

        it "生年月日を未来の日付で入力すると、エラーメッセージが表示されること" do
          visit(new_my_history_path)
          fill_in("birthday", with: Date.current.tomorrow.strftime("00%Y-%m-%d"))
          select("男性", from: "gender")
          click_button("更新")
          expect(page).to have_content("生年月日は未来の日付を入力できません")
        end

        it "生年月日を100歳より大きい年月日で選択すると、エラーメッセージが表示されること" do
          visit(new_my_history_path)
          fill_in("birthday", with: Date.current.ago(101.years).strftime("00%Y-%m-%d"))
          select("男性", from: "gender")
          click_button("更新")
          expect(page).to have_content("生年月日は0歳以上100歳以下で選択してください")
        end

        it "性別が未選択の場合、エラーメッセージが表示されること" do
          visit(new_my_history_path)
          fill_in("birthday", with: Date.current.ago(20.years).strftime("00%Y-%m-%d"))
          click_button("更新")
          expect(page).to have_content("性別を選択してください")
        end

        it "タイトルを50文字より多く入力すると、エラーメッセージが表示されること" do
          my_history.call
          fill_in("title", with: "あ" * 51)
          click_button("追加")
          expect(page).to have_content("タイトルは50文字以内で入力してください")
        end

        it "未入力の場合、エラーメッセージが表示されること" do
          my_history.call(true)
          click_button("出来事追加")
          click_button("追加")
          expect(page).to have_content("年齢を入力してください")
          expect(page).to have_content("充実度を入力してください")
          expect(page).to have_content("タイトルを入力してください")
          expect(page).to have_content("エピソードを入力してください")
        end

        it "年齢が0未満の場合は、エラーメッセージが表示されること" do
          my_history.call(true)
          click_button("出来事追加")
          fill_in("age",	with: "-1")
          click_button("追加")
          expect(page).to have_content("年齢は０以上で入力してください")
        end

        it "ユーザーの現在年齢より未来を入力した場合、エラーメッセージが表示されること" do
          my_history.call(true)
          click_button("出来事追加")
          fill_in("age",	with: "21")
          click_button("追加")
          expect(page).to have_content("年齢は過去しか入力できません")
        end

        it "出来事のタイトルが50文字より大きい場合、エラーメッセージが表示されること" do
          my_history.call(true)
          click_button("出来事追加")
          fill_in("title",	with: "あ" * 51)
          click_button("追加")
          expect(page).to have_content("タイトルは50文字以内で入力してください")
        end

        it "エピソードが65535文字より大きい場合、エラーメッセージが表示されること" do
          my_history.call(true)
          click_button("出来事追加")
          fill_in("episode",	with: "あ" * 65_536)
          click_button("追加")
          expect(page).to have_content("エピソードは65535文字以内で入力してください")
        end

        it "充実度が-100%未満を入力すると、エラーメッセージが表示されること" do
          my_history.call(true)
          click_button("出来事追加")
          fill_in("happiness",	with: "-101")
          click_button("追加")
          expect(page).to have_content("充実度は-100以上の値にしてください")
        end

        it "充実度が100%より大きい場合、エラーメッセージが表示されること" do
          my_history.call(true)
          click_button("出来事追加")
          fill_in("happiness",	with: "101")
          click_button("追加")
          expect(page).to have_content("充実度は100以下の値にしてください")
        end

        it "自分史は1つしか作成できないこと" do
          my_history.call(true, true)
          visit(current_path)
          fill_in("title",	with: "タイトル")
          click_button("追加")
          expect(page).to have_content("既に自分史は作成済みです。")
        end
      end
    end
  end
end
