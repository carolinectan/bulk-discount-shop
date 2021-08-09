class DateService < ApiService
  def date
    endpoint = 'https://date.nager.at/api/v2/NextPublicHolidays/US'
    get_data(endpoint)
  end
end
