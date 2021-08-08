class BulkDiscounts < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :percentage, presence: true, numericality: true

  belongs_to :merchant
  # has_many :
  # has_many :, through: :
end
