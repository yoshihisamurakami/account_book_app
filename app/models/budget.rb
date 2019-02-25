class Budget < ApplicationRecord
  validates :target_year,    presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :target_month,   presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :regular_income, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :extra_income,   presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :special_income, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :tax_funding,    presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :special_funding, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :savings,        presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :fixed_budget,   presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
