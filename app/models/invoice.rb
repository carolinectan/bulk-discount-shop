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

  # invoice => look at all invoice items
  # calculate the discount price for each invoice item => (ii.quantity * ii.unit_price * (ii.discount_applied/100))
  # sum that => discount_price in cents
  def discount
    self.invoice_items.map do |ii|
      if ii.discount_applied != nil # if ii qualifies for a discount
        ii.quantity * ii.unit_price * (ii.discount_applied.percentage/100.0)
      else # if no discount applies to ii
        ii.quantity * ii.unit_price
      end
    end.sum

    # DRAFT 2
    # invoice_items
    # .joins(item: [merchant: :bulk_discounts])
    # .select('sum(bulk_discount.percentage * unit_price * quantity) as discount')
    # .group(:id)

    # DRAFT 1
    # invoice_items
    # .joins(item: [merchant: :bulk_discounts])
    # .select('invoice_items.*, sum(discount.percentage * unit_price * quantity) as discount')
    # .group(:id)

    # binding.pry
    # wip.first.percentage
    # wip.first.quantity
  end
end
