class Budget < ApplicationRecord
  validates :target_year, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
