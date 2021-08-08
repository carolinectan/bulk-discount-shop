require 'faraday'
require 'json'

# Returns the upcoming public holidays for the next 365 days for the US
response = Faraday.get 'https://date.nager.at/api/v2/NextPublicHolidays/US'

body = response.body #=> JSON object

holidays = JSON.parse(body) #=> array of hashes

holidays[0]['date'] #=> "2021-10-11"
holidays[0]['name'] #=> "Columbus Day"

holidays[1]['date'] #=> "2021-11-11"
holidays[1]['name'] #=> "Veterans Day"

holidays[2]['date'] #=> "2021-11-25"
holidays[2]['name'] #=> "Thanksgiving Day"

require "pry"; binding.pry
