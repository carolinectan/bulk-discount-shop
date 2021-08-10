class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  #determines which discount is applied to an invoice item
  def discount_applied
    self.item
        .merchant
        .bulk_discounts #=> [bulk_discount]
        .where("#{self.quantity} >= quantity")
        .order(percentage: :desc) #=> if nothing matches, returns []
        .first
  end
end
