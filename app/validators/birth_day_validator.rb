class BirthDayValidator < ActiveModel::EachValidator
  # 生年月日が未来 or 100歳以上の場合はエラー
  def validate_each(record, _attribute, value)
    return unless value
    return record.errors.add(:birthday, "は未来の日付を入力できません") if value.future?

    age = record.calc_age
    record.errors.add(:birthday, "は0歳以上100歳以下で選択してください") if age.negative? || age > 100
  end
end
