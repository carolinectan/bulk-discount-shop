require 'rails_helper'

RSpec.describe '' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hiking with Amanda')

    @bulk_discount1 = @merchant1.bulk_discounts.create!(quantity: 4, percentage: 30)
  end

  it 'can update a bulk discount' do
    visit merchant_bulk_discount_path(@merchant1.id, @bulk_discount1.id)

    expect(page).to have_content(@bulk_discount1.id)
    expect(page).to have_content(@bulk_discount1.quantity)
    expect(page).to have_content(@bulk_discount1.percentage)

    within "#bd-#{@bulk_discount1.id}" do
      click_link("Edit")
    end

    expect(page).to have_field('Quantity', with: @bulk_discount1.quantity)
    expect(page).to have_field('Percentage', with: @bulk_discount1.percentage)

    fill_in('Quantity', with: 6)
    fill_in('Percentage', with: 15)

    click_on('Update Bulk discount')

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bulk_discount1))
    expect(page).to have_content(6)
    expect(page).to have_content(15)
    expect(page).to have_content("Bulk Discount ##{@bulk_discount1.id} was successfully updated!")
  end

  it 'can update just one attribute' do
    visit merchant_bulk_discount_path(@merchant1.id, @bulk_discount1.id)

    expect(page).to have_content(@bulk_discount1.id)
    expect(page).to have_content(@bulk_discount1.quantity)
    expect(page).to have_content(@bulk_discount1.percentage)

    within "#bd-#{@bulk_discount1.id}" do
      click_link("Edit")
    end

    expect(page).to have_field('Quantity', with: @bulk_discount1.quantity)
    expect(page).to have_field('Percentage', with: @bulk_discount1.percentage)

    fill_in('Quantity', with: 7)

    click_on('Update Bulk discount')

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bulk_discount1))
    expect(page).to have_content(7)
    expect(page).to have_no_content(4)
    expect(page).to have_content(30)
    expect(page).to have_content("Bulk Discount ##{@bulk_discount1.id} was successfully updated!")
  end
end
