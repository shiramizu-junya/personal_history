require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:user){ create(:user) }
  let(:my_history){ create(:my_history) }

  describe "バリデーション確認" do
    it "コメントが500文字以内であれば有効" do
      comment = build(:comment, body: "あ" * 500, user_id: user.id, my_history_id: my_history.id)
      expect(comment).to be_valid
      expect(comment.errors).to be_empty
    end

    it "コメントが500文字より大きい場合は無効" do
      comment = build(:comment, body: "あ" * 501, user_id: user.id, my_history_id: my_history.id)
      comment.valid?
      expect(comment.errors[:body]).to eq ["は500文字以内で入力してください"]
    end
  end
end
