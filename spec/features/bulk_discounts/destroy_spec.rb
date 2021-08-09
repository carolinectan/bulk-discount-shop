require 'rails_helper'

RSpec.describe "deleting a merchant's bulk discount" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Ornithology with Sami')

    @bulk_discount1 = @merchant1.bulk_discounts.create!(quantity: 4, percentage: 30)
    @bulk_discount2 = @merchant1.bulk_discounts.create!(quantity: 2, percentage: 50)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it 'can delete a bulk discount' do
    expect(page).to have_content(@bulk_discount1.id)
    expect(page).to have_content(@bulk_discount2.id)

    within "#bd-#{@bulk_discount1.id}" do
      click_on('Delete')
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1.id))
    expect(page).to have_no_content(@bulk_discount1.id)
    expect(page).to have_content(@bulk_discount2.id)
  end
end
