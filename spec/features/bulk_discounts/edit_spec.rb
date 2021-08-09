require 'rails_helper'

RSpec.describe '' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hiking with Amanda')

    @bulk_discount1 = @merchant1.bulk_discounts.create!(quantity: 4, percentage: 30)
    @bulk_discount2 = @merchant1.bulk_discounts.create!(quantity: 2, percentage: 50)
  end

  it 'can update a bulk discount' do
    visit merchant_bulk_discount_path(@merchant1.id, @bulk_discount1.id)

    expect(page).to have_content(@bulk_discount1.id)
    expect(page).to have_content(@bulk_discount1.quantity)
    expect(page).to have_content(@bulk_discount1.percentage)

    within "#bd-#{@bulk_discount1.id}" do
      click_link("Edit")
    end
save_and_open_page
    expect(page).to have_content(@bulk_discount1.quantity)
    expect(page).to have_content(@bulk_discount1.percentage)

    # Then I am taken to a new page with a form to edit the discount
    # And I see that the discounts current attributes are pre-poluated in the form
    # When I change any/all of the information and click submit
    # Then I am redirected to the bulk discount's show page
    # And I see that the discount's attributes have been updated
  end
end
