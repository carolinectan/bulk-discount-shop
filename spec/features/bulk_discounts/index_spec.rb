require 'rails_helper'
require '././app/poros/holidays.rb'

RSpec.describe "merchant's bulk discounts index page" do
  before :each do
    BulkDiscount.destroy_all
    Merchant.destroy_all

    @merchant1 = Merchant.create!(name: 'Ornithology with Sami')
    @merchant2 = Merchant.create!(name: 'Beats with Elliot')

    @bulk_discount1 = @merchant1.bulk_discounts.create!(quantity: 4, percentage: 30)
    @bulk_discount2 = @merchant1.bulk_discounts.create!(quantity: 2, percentage: 50)
    @bulk_discount3 = @merchant2.bulk_discounts.create!(quantity: 1, percentage: 70)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it "displays the merchant's bulk discounts including their percentage discount and quantity thresholds" do
    expect(page).to have_content("#{@merchant1.name}'s Bulk Discounts")

    within("#bd-#{@bulk_discount1.id}") do
      expect(page).to have_content("Bulk Discount ##{@bulk_discount1.id}")
      expect(page).to have_content("Quantity Threshold: #{@bulk_discount1.quantity}")
      expect(page).to have_content("Percentage Discount: #{@bulk_discount1.percentage}")
    end

    within("#bd-#{@bulk_discount2.id}") do
      expect(page).to have_content("Bulk Discount ##{@bulk_discount2.id}")
      expect(page).to have_content("Quantity Threshold: #{@bulk_discount2.quantity}")
      expect(page).to have_content("Percentage Discount: #{@bulk_discount2.percentage}")
    end

    expect(page).to have_no_content("Bulk Discount ##{@bulk_discount3.id}")
    expect(page).to have_no_content("Quantity Threshold: #{@bulk_discount3.quantity}")
    expect(page).to have_no_content("Percentage Discount: #{@bulk_discount3.percentage}")
  end

  it "displays a link to each bulk discount's show page" do
    expect(page).to have_link(@bulk_discount1.id)
    expect(page).to have_link(@bulk_discount2.id)
    expect(page).to have_no_link(@bulk_discount3.id)
  end

  it "links to the bulk discount's show page" do
    click_link(@bulk_discount1.id)

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1.id, @bulk_discount1.id))
  end

  describe 'holidays API' do
    it "has a section with a header of 'Upcoming Holidays'" do
      expect(page).to have_content('Next 3 Upcoming Holidays')
    end

    it 'displays the name and date of the next 3 upcoming US holidays' do
      expect(page).to have_content('Labour Day')
      expect(page).to have_content('2021-09-06')
      expect(page).to have_content('Columbus Day')
      expect(page).to have_content('2021-10-11')
      expect(page).to have_content('Veterans Day')
      expect(page).to have_content('2021-11-11')
    end
  end

  it 'has a link to create a new bulk discount' do
    expect(page).to have_link('Create a New Bulk Discount')

    click_link('Create a New Bulk Discount')

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
  end

  it 'displays buttons to delete bulk discounts' do
    within "#bd-#{@bulk_discount1.id}" do
      expect(page).to have_link("Delete")
    end

    within "#bd-#{@bulk_discount2.id}" do
      expect(page).to have_link("Delete")
    end
  end
end
