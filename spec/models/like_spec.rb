require "rails_helper"

RSpec.describe Like, type: :model do
  let(:user){ create(:user) }
  let(:my_history){ create(:my_history) }

  describe "バリデーション確認" do
    it "user_idとmy_history_idの組み合わせがuniqueであれば有効" do
      like = build(:like, user_id: user.id, my_history_id: my_history.id)
      expect(like).to be_valid
      expect(like.errors).to be_empty
    end

    it "user_idとmy_history_idの組み合わせがuniqueでなければ無効" do
      like_1 = create(:like, user_id: user.id, my_history_id: my_history.id)
      like_2 = build(:like, user_id: user.id, my_history_id: my_history.id)
      like_2.valid?
      expect(like_2.errors[:user_id]).to eq ["はすでに存在します"]
    end
  end
end
