require "rails_helper"

RSpec.describe User, type: :model do
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
