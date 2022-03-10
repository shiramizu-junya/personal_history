require "rails_helper"

RSpec.describe "Users", type: :system do
  describe "ユーザー登録ページ" do
    context "ユーザー登録前" do
      context "正常系" do
        it "ヘッダーのリンクをクリックすると、ユーザー登録ページが表示されること" do
          visit(root_path)
          click_link("新規登録")
          expect(current_path).to eq(new_user_path)
          expect(page).to have_content("ユーザー登録")
        end

        it "フォームに正しく入力すると、ユーザー登録が完了すること" do
          visit(new_user_path)
          fill_in("ユーザー名", with: "ユーザー")
          fill_in("メールアドレス", with: "sample@example.com")
          fill_in("パスワード", with: "password")
          fill_in("パスワード（確認用）", with: "password")
          click_button("登録")
          expect(current_path).to eq(my_histories_path)
        end
      end

      context "異常系" do
        it "ユーザー名が未入力の場合、エラーメッセージが表示されること" do
          visit(new_user_path)
          fill_in("メールアドレス", with: "sample@example.com")
          fill_in("パスワード", with: "password")
          fill_in("パスワード（確認用）", with: "password")
          click_button("登録")
          expect(page).to have_content("ユーザー名を入力してください")
        end

        it "メールアドレスが重複している場合、エラーメッセージが表示されること" do
          user = create(:user)
          visit(new_user_path)
          fill_in("ユーザー名", with: "ユーザー")
          fill_in("メールアドレス", with: user.email)
          fill_in("パスワード", with: "password")
          fill_in("パスワード（確認用）", with: "password")
          click_button("登録")
          expect(page).to have_content("メールアドレスはすでに存在します")
        end

        it "パスワードが8文字未満の場合、エラーメッセージが表示されること" do
          visit(new_user_path)
          fill_in("ユーザー名", with: "ユーザー")
          fill_in("メールアドレス", with: "sample@example.com")
          fill_in("パスワード", with: "passwor")
          fill_in("パスワード（確認用）", with: "passwor")
          click_button("登録")
          expect(page).to have_content("パスワードは8文字以上で入力してください")
        end

        it "パスワードが未入力の場合、エラーメッセージが表示されること" do
          visit(new_user_path)
          fill_in("ユーザー名", with: "ユーザー")
          fill_in("メールアドレス", with: "sample@example.com")
          click_button("登録")
          expect(page).to have_content("パスワード（確認用）を入力してください")
        end

        it "パスワードとパスワード（確認用）が一致しない場合、エラーメッセージが表示されること" do
          visit(new_user_path)
          fill_in("ユーザー名", with: "ユーザー")
          fill_in("メールアドレス", with: "sample@example.com")
          fill_in("パスワード", with: "password")
          fill_in("パスワード（確認用）", with: "password_sample")
          click_button("登録")
          expect(page).to have_content("パスワード（確認用）とパスワードの入力が一致しません")
        end
      end
    end
  end
end
