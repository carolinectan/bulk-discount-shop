require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of(:invoice_id) }
    it { should validate_presence_of(:item_id) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe "relationships" do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  ##### Examples #####
  describe 'class methods' do
    describe ".discount_applied" do
      it "(EXAMPLE 1) returns nil if the invoice item doesn't meet the bulk discount's quantity threshold" do
        merchant1 = Merchant.create!(name: 'Potato Stand')

        bulk_discount1 = merchant1.bulk_discounts.create!(percentage: 20, quantity: 10)

        item1 = merchant1.items.create!(name: 'Purple Potato', description: 'Very purple', unit_price: 1405)
        item2 = merchant1.items.create!(name: 'Yukon Gold Potato', description: 'Large and gold', unit_price: 2800)

        customer1 = Customer.create!(first_name: 'Polly', last_name: 'Pocket')

        invoice1 = customer1.invoices.create!(status: 2)

        invoiceitem1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 5, unit_price: 2005, status: 2)
        invoiceitem2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 5, unit_price: 3000, status: 2)

        expect(invoiceitem1.discount_applied).to eq(nil)
        expect(invoiceitem2.discount_applied).to eq(nil)
      end

      it "(EXAMPLE 2) applies a discount only to invoice items that meet the bulk discount's quantity threshold" do
        merchant1 = Merchant.create!(name: 'Potato Stand')

        bulk_discount1 = merchant1.bulk_discounts.create!(percentage: 20, quantity: 10)

        item1 = merchant1.items.create!(name: 'Purple Potato', description: 'Very purple', unit_price: 1405)
        item2 = merchant1.items.create!(name: 'Yukon Gold Potato', description: 'Large and gold', unit_price: 2800)

        customer1 = Customer.create!(first_name: 'Polly', last_name: 'Pocket')

        invoice1 = customer1.invoices.create!(status: 2)

        invoiceitem1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 10, unit_price: 2005, status: 2)
        invoiceitem2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 5, unit_price: 3000, status: 2)

        expect(invoiceitem1.discount_applied).to eq(bulk_discount1)
        expect(invoiceitem2.discount_applied).to eq(nil)
      end

      it "(EXAMPLE 3) applies the highest discount an invoice items qualifies for" do
        merchant1 = Merchant.create!(name: 'Potato Stand')

        bulk_discount1 = merchant1.bulk_discounts.create!(percentage: 20, quantity: 10)
        bulk_discount2 = merchant1.bulk_discounts.create!(percentage: 30, quantity: 15)

        item1 = merchant1.items.create!(name: 'Purple Potato', description: 'Very purple', unit_price: 1405)
        item2 = merchant1.items.create!(name: 'Yukon Gold Potato', description: 'Large and gold', unit_price: 2800)

        customer1 = Customer.create!(first_name: 'Polly', last_name: 'Pocket')

        invoice1 = customer1.invoices.create!(status: 2)

        invoiceitem1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 12, unit_price: 2005, status: 2)
        invoiceitem2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 15, unit_price: 3000, status: 2)

        expect(invoiceitem1.discount_applied).to eq(bulk_discount1)
        expect(invoiceitem2.discount_applied).to eq(bulk_discount2)
      end
    end
  end
end
