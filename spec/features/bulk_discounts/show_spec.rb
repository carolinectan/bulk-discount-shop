require 'rails_helper'

RSpec.describe "the merchant's bulk discount show page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hiking with Amanda')

    @bulk_discount1 = @merchant1.bulk_discounts.create!(quantity: 4, percentage: 30)
    @bulk_discount2 = @merchant1.bulk_discounts.create!(quantity: 2, percentage: 50)

    visit merchant_bulk_discount_path(@merchant1.id, @bulk_discount1.id)
  end

  it "displays the bulk discount's quantity threshold and percentage discount" do
    within "#bd-#{@bulk_discount1.id}" do
      expect(page).to have_content("Quantity Threshold: #{@bulk_discount1.quantity}")
      expect(page).to have_content("Percentage Discount: #{@bulk_discount1.percentage}%")
    end
  end
end
