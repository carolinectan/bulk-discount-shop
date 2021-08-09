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
    # before :each do
    # https://github.com/BrianZanti/intro_to_apis/tree/main/lib
    #   mock_response =
    #   '{
    #     "date": "2021-11-11",
    #     "localName": "Veterans Day",
    #     "name": "Veterans Day",
    #     "countryCode": "US",
    #     "fixed": false,
    #     "global": true,
    #   },
    #   {
    #     "date": "2021-11-25",
    #     "localName": "Thanksgiving Day",
    #     "name": "Thanksgiving Day",
    #     "countryCode": "US",
    #     "fixed": false,
    #     "global": true,
    #     "launchYear": 1863,
    #   },
    #   {
    #     "date": "2021-12-24",
    #     "localName": "Christmas Day",
    #     "name": "Christmas Day",
    #     "countryCode": "US",
    #     "fixed": false,
    #     "global": true,
    #   },
    #   {
    #     "date": "2021-12-31",
    #     "localName": "New Year's Day",
    #     "name": "New Year's Day",
    #     "countryCode": "US",
    #     "fixed": false,
    #     "global": true
    #   }'
    #
    #   allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)
    # end

    it "has a section with a header of 'Upcoming Holidays'" do
      expect(page).to have_content('Next 3 Upcoming Holidays:')
    end

    xit 'exists' do
      holiday = Holiday.new(repo)

      expect(holiday).to be_an_instance_of(Holiday)
    end

    xit 'receives the user infor and stores relevant attributes' do
      holiday = Holiday.new(repo)

      allow(holiday).to receive(:name1).and_return('Veterans Day')
      expect(holiday.name1).to eq('Veterans Day')

      allow(holiday).to receive(:date1).and_return('2021-11-11')
      expect(holiday.date1).to eq('2021-11-11')

      allow(holiday).to receive(:name2).and_return('Thanksgiving Day')
      expect(holiday.name2).to eq('Thanksgiving Day')

      allow(holiday).to receive(:date2).and_return('2021-11-25')
      expect(holiday.date2).to eq('2021-11-25')

      allow(holiday).to receive(:name3).and_return('Christmas Day')
      expect(holiday.name3).to eq('Christmas Day')

      allow(holiday).to receive(:date3).and_return('2021-12-24')
      expect(holiday.date3).to eq('2021-12-24')
    end

    # Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)
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
