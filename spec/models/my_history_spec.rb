require "rails_helper"

RSpec.describe MyHistory, type: :model do
  describe "バリデーション確認" do
    it "公開設定で「公開」を選択した場合は有効" do
      my_history= build(:my_history)
      expect(my_history).to be_valid
      expect(my_history.errors).to be_empty
    end

    it "公開設定で「非公開」を選択した場合は有効" do
      my_history = build(:my_history, status: :unpublished)
      expect(my_history).to be_valid
      expect(my_history.errors).to be_empty
    end

    it "タイトルが50文字以内の場合は有効" do
      my_history = build(:my_history, title: "あ" * 50)
      expect(my_history).to be_valid
      expect(my_history.errors).to be_empty
    end

    it "タイトル未入力の場合は無効" do
      my_history = build(:my_history, title: "")
      my_history.valid?
      expect(my_history.errors[:title]).to eq ["を入力してください"]
    end

    it "タイトルが50文字より大きい場合は無効" do
      my_history = build(:my_history, title: "あ" * 51)
      my_history.valid?
      expect(my_history.errors[:title]).to eq ["は50文字以内で入力してください"]
    end
  end
end
