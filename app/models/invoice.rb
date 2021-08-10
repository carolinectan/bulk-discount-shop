class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  # enum status: [:cancelled, 'in progress', :completed]
  enum status: { cancelled: 0,  'in progress'  => 1, completed: 2 }

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discounted_revenue
    total_revenue - discount
  end

  def discount
    self.invoice_items.map do |ii|
      if ii.discount_applied != nil
        ii.quantity * ii.unit_price * (ii.discount_applied.percentage / 100.0)
      else
        ii.quantity * ii.unit_price
      end
    end.sum
  end
  # DRAFT / WIP
  # invoice_items
  # .joins(item: [merchant: :bulk_discounts])
  # .select('invoice_items.*, bulk_discounts.* sum(invoice_items.unit_price * invoice_items.quantity * bulk_discount.percentage * ) as discount_calc')
  # .where('invoice_items.quantity >= bulk_discounts.quantity')

  # Maybe? .group(:id)
end
