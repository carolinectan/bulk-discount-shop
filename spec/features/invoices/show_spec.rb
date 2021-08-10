require 'rails_helper'

RSpec.describe 'invoices show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @bulk_discount1 = @merchant1.bulk_discounts.create!(percentage: 20, quantity: 9)
    @bulk_discount2 = @merchant1.bulk_discounts.create!(percentage: 30, quantity: 15)

    @item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
    @item7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: @merchant1.id)
    @item8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

    @item5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
    @item6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

    @customer1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer6 = Customer.create!(first_name: 'Herber', last_name: 'Coon')

    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 2, created_at: "2012-03-28 14:54:09")
    @invoice3 = Invoice.create!(customer_id: @customer2.id, status: 2)
    @invoice4 = Invoice.create!(customer_id: @customer3.id, status: 2)
    @invoice5 = Invoice.create!(customer_id: @customer4.id, status: 2)
    @invoice6 = Invoice.create!(customer_id: @customer5.id, status: 2)
    @invoice7 = Invoice.create!(customer_id: @customer6.id, status: 2)
    @invoice8 = Invoice.create!(customer_id: @customer6.id, status: 1)

    @ii1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 9, unit_price: 1000, status: 2)
    @ii2 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item1.id, quantity: 1, unit_price: 1000, status: 2)
    @ii3 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item2.id, quantity: 2, unit_price: 800, status: 2)
    @ii4 = InvoiceItem.create!(invoice_id: @invoice4.id, item_id: @item3.id, quantity: 3, unit_price: 500, status: 1)
    @ii6 = InvoiceItem.create!(invoice_id: @invoice5.id, item_id: @item4.id, quantity: 1, unit_price: 100, status: 1)
    @ii7 = InvoiceItem.create!(invoice_id: @invoice6.id, item_id: @item7.id, quantity: 1, unit_price: 300, status: 1)
    @ii8 = InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item8.id, quantity: 1, unit_price: 500, status: 1)
    @ii9 = InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item4.id, quantity: 1, unit_price: 100, status: 1)
    @ii10 = InvoiceItem.create!(invoice_id: @invoice8.id, item_id: @item5.id, quantity: 1, unit_price: 100, status: 1)
    @ii11 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item8.id, quantity: 12, unit_price: 600, status: 1)
    @ii12 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item6.id, quantity: 10, unit_price: 200, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice2.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice3.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice4.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice5.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice6.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice7.id)
    @transaction8 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice8.id)
  end

  it "shows the invoice information" do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
    expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %-d, %Y"))
  end

  it "shows the customer information" do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(@customer1.first_name)
    expect(page).to have_content(@customer1.last_name)
    expect(page).to_not have_content(@customer2.last_name)
  end

  it "shows the item information" do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@ii1.quantity)
    expect(page).to have_content(@ii1.unit_price / 100.00)
    expect(page).to_not have_content(@ii4.unit_price / 100.00)
  end

  it "shows the total revenue for this invoice" do
    visit merchant_invoice_path(@merchant1, @invoice1)

    expect(page).to have_content(@invoice1.total_revenue / 100.00)
  end

  it "shows a select field to update the invoice status" do
    visit merchant_invoice_path(@merchant1, @invoice1)

    within("#the-status-#{@ii1.id}") do
      page.select("cancelled")
      click_button "Update Invoice"

      expect(page).to have_content("cancelled")
     end

     within("#current-invoice-status") do
       expect(page).to_not have_content("in progress")
     end
  end

  it 'displays the total revenue (NOT including discounts) for a merchant from a specific invoice' do
    visit merchant_invoice_path(@merchant1.id, @invoice1.id)

    expect(page).to have_content("Total Revenue: $182.00")
    expect(page).to have_content("Total Revenue: $#{@invoice1.total_revenue / 100}")
  end

  it 'displays the total discounted revenue for a merchant from a specific invoice which INCLUDES bulk discounts in the calculation' do
    visit merchant_invoice_path(@merchant1.id, @invoice1.id)

    expect(page).to have_content('$129.60')
    expect(page).to have_content("Total Discounted Revenue: $#{@invoice1.total_discounted_revenue / 100}")
  end

  it 'displays a link next to each invoice item to the show page for the bulk discount that was applied (if any)' do
    visit merchant_invoice_path(@merchant1.id, @invoice1.id)

    within "#ii-#{@ii1.id}" do
      expect(page).to have_link('View Discount Applied')
    end

    within "#ii-#{@ii11.id}" do
      expect(page).to have_link('View Discount Applied')
    end

    within "#ii-#{@ii12.id}" do
      expect(page).to have_no_link('View Discount Applied')
    end
  end
end
