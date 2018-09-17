class Account < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :comment, length: { maximum: 50 }
end
