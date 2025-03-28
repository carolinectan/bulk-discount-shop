require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:customer_id) }
  end

  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:transactions) }
  end

  describe "instance methods" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 9, unit_price: 10, status: 2)
      @ii11 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item8.id, quantity: 1, unit_price: 10, status: 1)
      @bulk_discount1 = @merchant1.bulk_discounts.create!(percentage: 20, quantity: 9)
      @bulk_discount2 = @merchant1.bulk_discounts.create!(percentage: 30, quantity: 15)
    end

    it "#total_revenue" do
      expect(@invoice1.total_revenue).to eq(100)
    end

    it "#discount" do
      expect(@invoice1.discount).to eq(28)
    end

    it "#total_discounted_revenue" do
      expect(@invoice1.total_discounted_revenue).to eq(72)
    end
  end
end
