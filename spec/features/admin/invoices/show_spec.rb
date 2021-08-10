require 'rails_helper'

describe 'Admin Invoices Show Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Merchant 1')

    @customer1 = Customer.create!(first_name: 'Yo', last_name: 'Yoz', address: '123 Heyyo', city: 'Whoville', state: 'CO', zip: 12345)
    @customer2 = Customer.create!(first_name: 'Hey', last_name: 'Heyz')

    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 2, created_at: '2012-03-25 09:54:09')
    @invoice2 = Invoice.create!(customer_id: @customer2.id, status: 1, created_at: '2012-03-25 09:30:09')

    @item1 = Item.create!(name: 'test', description: 'lalala', unit_price: 6, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'rest', description: 'dont test me', unit_price: 12, merchant_id: @merchant1.id)

    @ii1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 12, unit_price: 20, status: 0)
    @ii2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 6, unit_price: 10, status: 1)
    @ii3 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item2.id, quantity: 88, unit_price: 1200, status: 2)

    visit admin_invoice_path(@invoice1)
  end

  it 'should display the id, status and created_at' do
    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Created on: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")

    expect(page).to have_no_content("Invoice ##{@invoice2.id}")
  end

  it 'should display the customers name and shipping address' do
    expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}")
    expect(page).to have_content(@customer1.address)
    expect(page).to have_content("#{@customer1.city}, #{@customer1.state} #{@customer1.zip}")

    expect(page).to have_no_content("#{@customer2.first_name} #{@customer2.last_name}")
  end

  it 'should display all the items on the invoice' do
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)

    expect(page).to have_content(@ii1.quantity)
    expect(page).to have_content(@ii2.quantity)

    expect(page).to have_content("$#{@ii1.unit_price}")
    expect(page).to have_content("$#{@ii2.unit_price}")

    expect(page).to have_content(@ii1.status)
    expect(page).to have_content(@ii2.status)

    expect(page).to have_no_content(@ii3.quantity)
    expect(page).to have_no_content("$#{@ii3.unit_price}")
    expect(page).to have_no_content(@ii3.status)
  end

  it 'should have status as a select field that updates the invoices status' do
    within("#status-update-#{@invoice1.id}") do
      select('cancelled', :from => 'invoice[status]')
      expect(page).to have_button('Update Invoice')
      click_button 'Update Invoice'

      expect(current_path).to eq(admin_invoice_path(@invoice1))
      expect(@invoice1.status).to eq('completed')
    end
  end
  
  it 'displays the total revenue (NOT including discounts) for an admin from a specific invoice' do
    expect(page).to have_content("Total Revenue: $#{@invoice1.total_revenue / 100}")

    expect(page).to have_no_content(@invoice2.total_revenue)
  end

  it 'displays the total discounted revenue for an admin from a specific invoice which INCLUDES bulk discounts in the calculation' do
    save_and_open_page
    expect(page).to have_content("Total Discounted Revenue: $#{@invoice1.total_discounted_revenue / 100}")
  end
end
