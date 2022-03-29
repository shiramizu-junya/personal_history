class EventAgeValidator < ActiveModel::EachValidator
  # イベントの年齢が未来の場合はエラー
  def validate_each(record, attribute, value)
    return unless value
    age = record.my_history.user.calc_age

    if value > age
      record.errors.add(attribute, "は過去しか入力できません")
    elsif value.negative?
      record.errors.add(attribute, "は０以上で入力してください")
    end
  end
end
