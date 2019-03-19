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

  def income_total
    regular_income + extra_income
  end

  def payments_total
    tax_funding + special_funding + savings
  end

  def cost_of_living
    income_total - payments_total
  end

  def cost_of_living_without_fixed
    cost_of_living - fixed_budget
  end

  def self.get_by_target(target)
    self.where(
      target_year: target.year,
      target_month: target.month
    ).first
  end

end
