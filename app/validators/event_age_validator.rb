class EventAgeValidator < ActiveModel::EachValidator
  # イベントの年齢が未来の場合はエラー
  def validate_each(record, _attribute, value)
    return unless value

    age = User.current_user.calc_age
    if value > age
      record.errors.add(:age, "は過去しか入力できません")
    elsif value.negative?
      record.errors.add(:age, "は０以上で入力してください")
    end
  end
end
