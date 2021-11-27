class EventAgeValidator < ActiveModel::EachValidator
  # イベントの年齢が未来の場合はエラー
  def validate_each(record, attribute, value)
    return unless value
    age = User.current_user.calc_age
    record.errors.add(:age, "は過去しか入力できません") if value > age
  end
end
