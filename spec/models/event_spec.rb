require "rails_helper"

RSpec.describe Event, type: :model do
  let(:user) { create(:user, birthday: Date.current.ago(30.years).strftime("%Y-%m-%d")) }

  describe "バリデーション確認" do
    it "出来事の年齢がユーザー年齢以下であれば有効" do
      event = build(:event, age: user.calc_age)
      expect(event).to be_valid
      expect(event.errors).to be_empty
    end

    it "出来事の年齢が0以上であれば有効" do
      event = build(:event, age: 0)
      expect(event).to be_valid
      expect(event.errors).to be_empty
    end

    it "タイトルが50文字以下であれば有効" do
      event = build(:event, title: "あ" * 50)
      expect(event).to be_valid
      expect(event.errors).to be_empty
    end

    it "エピソードが65_535文字以内であれば有効" do
      event = build(:event, episode: "あ" * 65_535)
      expect(event).to be_valid
      expect(event.errors).to be_empty
    end

    it "充実度が「-100以上〜100以下」であれば有効" do
      event_happiness_max = build(:event, happiness: 100)
      event_happiness_min = build(:event, happiness: -100)
      expect(event_happiness_max).to be_valid
      expect(event_happiness_max.errors).to be_empty
      expect(event_happiness_min).to be_valid
      expect(event_happiness_min.errors).to be_empty
    end

    it "出来事の年齢が未入力であれば無効" do
      event = build(:event, age: nil)
      event.valid?
      expect(event.errors[:age]).to eq ["を入力してください", "は数値で入力してください"]
    end

    it "出来事の年齢が0未満であれば無効" do
      event = build(:event, age: -1)
      event.valid?
      expect(event.errors[:age]).to eq ["は０以上で入力してください"]
    end

    it "出来事の年齢がユーザー年齢より大きい場合は無効" do
      event = build(:event, age: user.calc_age + 1)
      event.valid?
      expect(event.errors[:age]).to eq ["は過去しか入力できません"]
    end

    it "タイトルが未入力であれば無効" do
      event = build(:event, title: nil)
      event.valid?
      expect(event.errors[:title]).to eq ["を入力してください"]
    end

    it "タイトルが50文字より大きい場合は無効" do
      event = build(:event, title: "あ" * 51)
      event.valid?
      expect(event.errors[:title]).to eq ["は50文字以内で入力してください"]
    end

    it "エピソードが65_535文字より大きい場合は無効" do
      event = build(:event, episode: "あ" * 65_536)
      event.valid?
      expect(event.errors[:episode]).to eq ["は65535文字以内で入力してください"]
    end

    it "充実度が-100より小さい場合は無効" do
      event = build(:event, happiness: -101)
      event.valid?
      expect(event.errors[:happiness]).to eq ["は-100以上の値にしてください"]
    end

    it "充実度が100より大きい場合は無効" do
      event = build(:event, happiness: 101)
      event.valid?
      expect(event.errors[:happiness]).to eq ["は100以下の値にしてください"]
    end
  end
end
