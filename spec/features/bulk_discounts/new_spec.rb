require 'rails_helper'

RSpec.describe '' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Brewing Beers with Jacob')

    visit new_merchant_bulk_discount_path(@merchant1)
  end

  it 'creates a new bulk discount for a merchant' do
    fill_in('quantity', with: 18)
    fill_in('percentage', with: 23)

    click_on('Submit')

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1.id))
    expect(page).to have_content(18)
    expect(page).to have_content(23)
  end
end
