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

  def discounted_revenue
    wip = invoice_items
    .joins(item: [merchant: :bulk_discounts])
    .select('sum(bulk_discount.percentage * unit_price * quantity) as discount')
    .group(:id)
    # binding.pry


    # DRAFT 1
    # wip = invoice_items
    # .joins(item: [merchant: :bulk_discounts])
    # .select('invoice_items.*, sum(discount.percentage * unit_price * quantity) as discount')
    # .group(:id)
    # binding.pry


    # wip.first.percentage
    # wip.first.quantity

  end
end
