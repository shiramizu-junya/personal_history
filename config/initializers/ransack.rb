Ransack.configure do |config|
  # xx歳以上（年月日以前）
  config.add_predicate "convert_age_gteq",
    arel_predicate: "lteq",
    formatter: -> (v) { v.years.ago.to_date },
    validator: proc { |v| v.present? },
    type: :integer,
    compounds: false

  # xx歳以下（年月日以降）
  config.add_predicate "convert_age_lteq",
    arel_predicate: "gteq",
    formatter: -> (v) { ((v + 1).years.ago + 1.day).to_date },
    validator: proc { |v| v.present? },
    type: :integer,
    compounds: false
end
