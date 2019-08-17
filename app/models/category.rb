class Category < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 255 }
  has_many :books

  def self.living
    self.where(is_tax: false, is_fixed: false).select(:id)
  end

  def self.tax
    self.where(is_tax: true).select(:id)
  end
end
