class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # 生年月日から年齢を計算する
  def calc_age
    (Time.zone.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i) / 10_000
  end
end
