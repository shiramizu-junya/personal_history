require "rails_helper"

RSpec.describe User, type: :model do
  let(:create_user){ create(:user) }

  describe "バリデーション確認" do
    it "ユーザー名が10文字以内で、メールアドレスがあり、パスワードが8文字以上であれば有効" do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it "ユーザー名が未入力であれば、無効" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to eq ["を入力してください"]
    end

    it "ユーザー名が11文字以上であれば、無効" do
      user = build(:user, name: "abcdefghijk")
      user.valid?
      expect(user.errors[:name]).to eq ["は10文字以内で入力してください"]
    end

    it "メールアドレスが未入力であれば、無効" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to eq ["を入力してください"]
    end

    it "メールアドレスがユニークでなければ、無効" do
      user_2 = build(:user, email: create_user.email)
      user_2.valid?
      expect(user_2.errors[:email]).to eq ["はすでに存在します"]
    end

    it "パスワードが未入力であれば、無効" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to eq ["は8文字以上で入力してください"]
    end

    it "パスワードが7文字以内であれば、無効" do
      user = build(:user, password: "abcdefg")
      user.valid?
      expect(user.errors[:password]).to eq ["は8文字以上で入力してください"]
    end

    it "パスワード再入力が未入力であれば、無効" do
      user = build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to eq ["を入力してください"]
    end

    it "パスワードとパスワード再入力が不一致であれば、無効" do
      user = build(:user, password_confirmation: "abcdefgh")
      user.valid?
      expect(user.errors[:password_confirmation]).to eq ["とパスワードの入力が一致しません"]
    end

    it "生年月日が「現在日付以下」かつ「0歳以上100歳以下」であれば有効" do
      create_user.birthday = Date.current.strftime("%Y-%m-%d")
      create_user.valid?
      expect(create_user.errors[:birthday]).to be_empty
    end

    it "生年月日が未入力の場合は無効" do
      create_user.birthday = nil
      create_user.valid?
      expect(create_user.errors[:birthday]).to eq ["を入力してください"]
    end

    it "生年月日が未来の日付の場合は無効" do
      create_user.birthday = Date.tomorrow.strftime("%Y-%m-%d")
      create_user.valid?
      expect(create_user.errors[:birthday]).to eq ["は未来の日付を入力できません"]
    end

    it "生年月日が100歳より大きい場合は無効" do
      create_user.birthday = Date.current.ago(101.years).strftime("%Y-%m-%d")
      create_user.valid?
      expect(create_user.errors[:birthday]).to eq ["は0歳以上100歳以下で選択してください"]
    end

    it "性別が「男性」「女性」「その他」「未回答」のどれかを選択した場合は有効" do
      ["men", "women", "other", "no_answer"].each do |i|
        create_user.gender = i
        create_user.valid?
        expect(create_user.errors[:gender]).to be_empty
      end
    end

    it "性別が未選択の場合は無効" do
      create_user.gender = nil
      create_user.valid?
      expect(create_user.errors[:gender]).to eq ["を選択してください"]
    end
  end
end
