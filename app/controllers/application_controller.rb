class ApplicationController < ActionController::Base
end

private

def api_holidays
  json = DateService.new.date
  Holidays.new(json)
end
