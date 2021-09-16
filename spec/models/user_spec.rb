require "rails_helper"

RSpec.describe User, type: :model do
  describe "ユーザー登録機能" do
    describe "バリデーション" do
      it "ユーザー名が10文字以内で、メールアドレスがあり、パスワードが8文字以上であれば有効であること" do
        user = build(:user)
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end

      it "ユーザー名が未入力であれば、無効であること" do
        user = build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to eq ["を入力してください"]
      end

      it "ユーザー名が11文字以上であれば、無効であること" do
        user = build(:user, name: "abcdefghijk")
        user.valid?
        expect(user.errors[:name]).to eq ["は10文字以内で入力してください"]
      end

      it "メールアドレスが未入力であれば、無効であること" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to eq ["を入力してください"]
      end

      it "メールアドレスがユニークでなければ、無効であること" do
        user_1 = create(:user)
        user_2 = build(:user, email: user_1.email)
        user_2.valid?
        expect(user_2.errors[:email]).to eq ["はすでに存在します"]
      end

      it "パスワードが未入力であれば、無効であること" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to eq ["は8文字以上で入力してください"]
      end

      it "パスワードが7文字以内であれば、無効であること" do
        user = build(:user, password: "abcdefg")
        user.valid?
        expect(user.errors[:password]).to eq ["は8文字以上で入力してください"]
      end

      it "パスワード再入力が未入力であれば、無効であること" do
        user = build(:user, password_confirmation: nil)
        user.valid?
        expect(user.errors[:password_confirmation]).to eq ["を入力してください"]
      end

      it "パスワードとパスワード再入力が不一致であれば、無効であること" do
        user = build(:user, password_confirmation: "abcdefgh")
        user.valid?
        expect(user.errors[:password_confirmation]).to eq ["とパスワードの入力が一致しません"]
      end
    end
  end

  describe "プロフィール編集機能" do
    describe "バリデーション" do
      it "年齢が数値で0以上〜100以下であれば、有効であること" do
        user = create(:user)
        user.age = rand(0..100)
        user.gender = "men"
        user.valid?
        expect(user.errors).to be_empty
      end

      it "年齢が未入力であれば、無効であること" do
        user = create(:user)
        user.gender = "men"
        user.valid?
        expect(user.errors[:age]).to eq ["を入力してください", "は数値で入力してください"]
      end

      it "年齢が0未満であれば、無効であること" do
        user = create(:user)
        user.age = -1
        user.gender = "men"
        user.valid?
        expect(user.errors[:age]).to eq ["は0以上の値にしてください"]
      end

      it "年齢が100より大きいければ、無効であること" do
        user = create(:user)
        user.age = 101
        user.gender = "men"
        user.valid?
        expect(user.errors[:age]).to eq ["は100以下の値にしてください"]
      end

      it "性別が「男性」または「女性」であれば、有効であること" do
        user = create(:user)
        user.age = 50
        user.gender = ["men", "women"].sample
        user.valid?
        expect(user.errors).to be_empty
      end

      it "性別が未選択の場合、無効であること" do
        user = create(:user)
        user.age = 50
        user.valid?
        expect(user.errors[:gender]).to eq ["を選択してください"]
      end
    end
  end
end
