class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  # enum status: [:cancelled, 'in progress', :completed]
  enum status: { cancelled: 0,  "in progress"  => 1, completed: 2 }

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end
end
