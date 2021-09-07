require "rails_helper"

RSpec.describe "Users", type: :system do
  describe 'ログイン前' do
    describe "ユーザー新規登録画面" do
      context "フォームの入力値が正常な場合" do
        it "ユーザーの新規作成機能が成功すること" do
          visit new_user_path
          fill_in "ユーザー名",	with: "user"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザー登録が完了しました。"
          expect(current_path).to eq tracks_path
        end
      end

      context "ユーザー名が未入力の場合" do
        it "ユーザーの新規作成機能が失敗すること" do
          visit new_user_path
          fill_in "ユーザー名",	with: ""
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました。"
          expect(page).to have_content "ユーザー名を入力してください"
          expect(current_path).to eq users_path
        end
      end

      context "ユーザー名が11文字以上の場合" do
        it "ユーザーの新規作成機能が失敗すること" do
          visit new_user_path
          fill_in "ユーザー名",	with: "abcdefghijk"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました。"
          expect(page).to have_content "ユーザー名は10文字以内で入力してください"
          expect(page).to have_field "ユーザー名", with: "abcdefghijk"
          expect(current_path).to eq users_path
        end
      end

      context "メールアドレスが未入力の場合" do
        it "ユーザーの新規作成機能が失敗すること" do
          visit new_user_path
          fill_in "ユーザー名",	with: "user"
          fill_in "メールアドレス", with: ""
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました。"
          expect(page).to have_content "メールアドレスを入力してください"
          expect(current_path).to eq users_path
        end
      end

      context "登録済のメールアドレスを使用している場合" do
        it "ユーザーの新規作成機能が失敗すること" do
          existed_user = create(:user)
          visit new_user_path
          fill_in "ユーザー名",	with: "user"
          fill_in "メールアドレス", with: existed_user.email
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました。"
          expect(page).to have_content "メールアドレスはすでに存在します"
          expect(page).to have_field "メールアドレス", with: existed_user.email
          expect(current_path).to eq users_path
        end
      end

      context "パスワードが未入力の場合" do
        it "ユーザーの新規作成機能が失敗すること" do
          visit new_user_path
          fill_in "ユーザー名",	with: "user"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: ""
          fill_in "パスワード再入力", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました。"
          expect(page).to have_content "パスワードは8文字以上で入力してください"
          expect(current_path).to eq users_path
        end
      end

      context "パスワードが8文字未満の場合" do
        it "ユーザーの新規作成機能が失敗すること" do
          visit new_user_path
          fill_in "ユーザー名",	with: "user"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "passwor"
          fill_in "パスワード再入力", with: "passwor"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました。"
          expect(page).to have_content "パスワードは8文字以上で入力してください"
          expect(current_path).to eq users_path
        end
      end

      context "パスワードとパスワード再入力が不一致の場合" do
        it "ユーザーの新規作成機能
        が失敗すること" do
          visit new_user_path
          fill_in "ユーザー名",	with: "user"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: "abcdefgh"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました。"
          expect(page).to have_content "パスワード再入力とパスワードの入力が一致しません"
          expect(current_path).to eq users_path
        end
      end
    end
  end
end
